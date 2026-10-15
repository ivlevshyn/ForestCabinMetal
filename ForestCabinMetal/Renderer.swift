import Foundation
import MetalKit
import QuartzCore
import simd

enum RendererSetupError: Error{
    case commandBufferCreationFailed
    case sharedEventCreationFailed
    case metalLayerUnavailable
    case defaultLibraryUnavailable
    case vertexLayoutMismatch
    case invalidGeometry
    case bufferCreationFailed(String)
    case uniformLayoutMismatch
    case depthStateCreationFailed
}

class Renderer: NSObject, MTKViewDelegate{
    
    private var completionEvent: (any MTLSharedEvent)?
    private var lastSubmittedValue: UInt64? = nil
    private var commandBuffer: (any MTL4CommandBuffer)?
    private var commandAllocator: (any MTL4CommandAllocator)?
    private var inFlightDrawable: (any CAMetalDrawable)?
    private var flatTrianglePipeline: (any MTLRenderPipelineState)?
    private var colorTrianglePipeline: (any MTLRenderPipelineState)?
    private var animationTime: TimeInterval = 0
    private var previousAnimationSample: CFTimeInterval?
    
    private var animationPaused = false
    private var animationSceneActive = true
    private var lastResetID = 0
    
    private var scene: SceneResources?
    private var depthState: (any MTLDepthStencilState)?
    private var inFlightDepthTexture: (any MTLTexture)?
    
    private let useInterpolatedColor = true
    
    func setAnimationControls(
        paused: Bool,
        resetID: Int,
        sceneActive: Bool
    ) {
        if animationPaused != paused ||
            animationSceneActive != sceneActive {
            previousAnimationSample = nil
        }
        
        animationPaused = paused
        animationSceneActive = sceneActive
        
        if resetID != lastResetID {
            animationTime = 0
            previousAnimationSample = nil
            lastResetID = resetID
        }
    }
    
    private func updateAnimationTime() {
        guard !animationPaused, animationSceneActive else {
            previousAnimationSample = nil
            return
        }
        
        let now = CACurrentMediaTime()
        
        guard let previous = previousAnimationSample else {
            previousAnimationSample = now
            return
        }
        
        previousAnimationSample = now
        
        let deltaTime = now - previous
        
        guard deltaTime >= 0, deltaTime <= 0.25 else {
            return
        }
        
        animationTime += deltaTime
    }
    
    private func writeObjectUniforms(scene: SceneResources, aspect: Float) {
        let projection = makePerspective(verticalFOV: .pi / 3, aspect: aspect, near: 0.1, far: 30)
        
        let view = makeRotationX(0.3) * makeTranslation([0, -2.5, -6])
        
        let angle = Float((0.4 * animationTime).truncatingRemainder(dividingBy: 2 * Double.pi))
        
        let model = makeTranslation([0, 0.75, 0]) * makeRotationY(0.4 + angle) * makeScale([1.5, 1.5, 1.5])
        
        scene.writeUniforms(model: model, view: view, projection: projection, to: scene.boxUniforms)
        
        scene.writeUniforms(model: matrix_identity_float4x4, view: view, projection: projection, to: scene.groundUniforms)
    }
    
    private func encodeMesh(
        _ mesh: MeshBuffers,
        uniforms: any MTLBuffer,
        arguments: any MTL4ArgumentTable,
        encoder: any MTL4RenderCommandEncoder
    ) {
        arguments.setAddress(mesh.vertices.gpuAddress, index: 0)
        arguments.setAddress(uniforms.gpuAddress, index: 1)
        
        encoder.setArgumentTable(arguments, stages: .vertex)
        
        encoder.drawIndexedPrimitives(primitiveType: .triangle, indexCount: mesh.indexCount, indexType: .uint16, indexBuffer: mesh.indices.gpuAddress, indexBufferLength: mesh.indices.length)
    }
    
    func draw(in view: MTKView) {
        updateAnimationTime()
        
        guard let event = completionEvent else {
            return
        }
        
        if let pending = lastSubmittedValue,
           event.signaledValue < pending {
            return
        }
        
        inFlightDrawable = nil
        inFlightDepthTexture = nil
        
        guard view.drawableSize.width > 0,
              view.drawableSize.height > 0,
              let pass = view.currentMTL4RenderPassDescriptor,
              let drawable = view.currentDrawable,
              let depthTexture = pass.depthAttachment.texture,
              let buffer = commandBuffer,
              let allocator = commandAllocator,
              let queue = commandQueue,
              let scene,
              let depthState,
              let pipeline = useInterpolatedColor
                ? colorTrianglePipeline
                : flatTrianglePipeline else {
            return
        }
        
        let width = drawable.texture.width
        let height = drawable.texture.height
        
        guard width > 0,
              height > 0,
              depthTexture.width == width,
              depthTexture.height == height else {
            return
        }
        
        let color = pass.colorAttachments[0]!
        color.loadAction = .clear
        color.storeAction = .store
        color.clearColor = MTLClearColor(red: 0.16, green: 0.35, blue: 0.55, alpha: 1)
        
        pass.depthAttachment.loadAction = .clear
        pass.depthAttachment.storeAction = .store
        pass.depthAttachment.clearDepth = 1
        
        writeObjectUniforms(scene: scene, aspect: Float(width) / Float(height))
        
        allocator.reset()
        buffer.beginCommandBuffer(allocator: allocator)
        
        guard let encoder = buffer.makeRenderCommandEncoder(descriptor: pass, options: []) else {
            buffer.endCommandBuffer()
            return
        }
        
        encoder.label = "Lesson 05: box and ground"
        encoder.setRenderPipelineState(pipeline)
        encoder.setDepthStencilState(depthState)
        
        encoder.setViewport(MTLViewport(
            originX: 0, originY: 0, width: Double(width), height: Double(height), znear: 0, zfar: 1
        ))
        
        encoder.setFrontFacing(.counterClockwise)
        encoder.setCullMode(.back)
        
        encodeMesh(scene.box, uniforms: scene.boxUniforms, arguments: scene.arguments, encoder: encoder)
        
        encodeMesh(scene.ground, uniforms: scene.groundUniforms, arguments: scene.arguments, encoder: encoder)
        
        encoder.endEncoding()
        buffer.endCommandBuffer()
        
        let submissionValue = (lastSubmittedValue ?? 0) + 1
        
        let options = MTL4CommitOptions()
        options.addFeedbackHandler { feedback in
            if let error = feedback.error {
                print(error)
            }
        }
        
        inFlightDrawable = drawable
        inFlightDepthTexture = depthTexture
        
        queue.waitForDrawable(drawable)
        queue.commit([buffer], options: options)
        queue.signalDrawable(drawable)
        drawable.present()
        
        queue.signalEvent(event, value: submissionValue)
        lastSubmittedValue = submissionValue
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        print("New size: \(size)")
    }
    
    private var commandQueue: (any MTL4CommandQueue)?
    
    private func makeTrianglePipeline(
        compiler: any MTL4Compiler,
        library: any MTLLibrary,
        view: MTKView,
        fragmentName: String,
        label: String
    ) throws -> any MTLRenderPipelineState {
        let vertexFunction = MTL4LibraryFunctionDescriptor()
        vertexFunction.library = library
        vertexFunction.name = "triangleVertex"
        
        let fragmentFunction = MTL4LibraryFunctionDescriptor()
        fragmentFunction.library = library
        fragmentFunction.name = fragmentName
        
        let descriptor = MTL4RenderPipelineDescriptor()
        descriptor.label = label
        descriptor.vertexFunctionDescriptor = vertexFunction
        descriptor.fragmentFunctionDescriptor = fragmentFunction
        descriptor.colorAttachments[0].pixelFormat = view.colorPixelFormat
        descriptor.rasterSampleCount = view.sampleCount
        
        return try compiler.makeRenderPipelineState(descriptor: descriptor, dynamicLinkingDescriptor: nil, compilerTaskOptions: nil)
    }
    
    
    private func verifyTransformMath() {
        let pointA = SIMD4<Float>(0.5, 0.5, 0, 1)
        let pointB = SIMD4<Float>(-0.5, 0.25, 0, 1)
        
        let identity = matrix_identity_float4x4
        let scale = makeScale(SIMD3<Float>(2, 0.5, 1))
        
        let scaledA = scale * pointA
        let scaledB = scale * pointB
        
        assert(simd_length(identity * pointA - pointA) < 0.0001)
        assert(simd_length(identity * pointB - pointB) < 0.0001)
        
        assert(simd_length(scaledA - SIMD4<Float>(1, 0.25, 0, 1)) < 0.0001)
        
        assert (simd_length(scaledB - SIMD4<Float>(-1, 0.125, 0, 1)) < 0.0001)
        
        let xPoint = SIMD4<Float>(1, 0, 0, 1)
        let quarterTurn = makeRotationZ(Float.pi / 2)
        
        assert(simd_length(makeRotationZ(0) * xPoint - xPoint) < 0.0001)
        
        assert(simd_length(quarterTurn * xPoint - SIMD4<Float>(0, 1, 0, 1)) < 0.0001)
        
        print("Transform checks passed: \(scaledA), \(scaledB)")
    }
    
    func prepare(device: any MTLDevice, view: MTKView) throws {
        
        verifyTransformMath()
        verifyProjectionMath()
        
        let descriptor = MTL4CommandQueueDescriptor()
        descriptor.label = "Forest cabin queue"
                        
        guard let buffer = device.makeCommandBuffer() else {
            throw RendererSetupError.commandBufferCreationFailed
        }
        
        buffer.label = "Forest cabin command buffer"
        
        let allocatorDescriptor = MTL4CommandAllocatorDescriptor()
        allocatorDescriptor.label = "Forest cabin frame allocator"
        
        let allocator = try device.makeCommandAllocator(
            descriptor: allocatorDescriptor
        )
        
        self.commandBuffer = buffer
        self.commandAllocator = allocator
        
        print("Command storage ready")
        
        guard let event = device.makeSharedEvent() else {
            throw RendererSetupError.sharedEventCreationFailed
        }
        
        self.completionEvent = event
        
        print("Completion tracking ready; no submitted frame")
        
        let queue = try device.makeMTL4CommandQueue(
            descriptor: descriptor
        )
        
        guard let layer = view.layer as? CAMetalLayer else {
            throw RendererSetupError.metalLayerUnavailable
        }
        
        queue.addResidencySet(view.residencySet)
        queue.addResidencySet(layer.residencySet)
        self.commandQueue = queue
        print("Metal 4 queue ready")
        
        guard let library = device.makeDefaultLibrary() else {
            throw RendererSetupError.defaultLibraryUnavailable
        }

        let compilerDescriptor = MTL4CompilerDescriptor()
        let compiler = try device.makeCompiler(descriptor: compilerDescriptor)
        
        flatTrianglePipeline = try makeTrianglePipeline(compiler: compiler, library: library, view: view, fragmentName: "triangleFlatFragment", label: "Triangle - solid color")
        
        colorTrianglePipeline = try makeTrianglePipeline(compiler: compiler, library: library, view: view, fragmentName: "triangleColorFragment", label: "Triangle - interpolated color")
        
        print("Triangle pipeline ready")
        
        let depthDescriptor = MTLDepthStencilDescriptor()
        depthDescriptor.depthCompareFunction = .less
        depthDescriptor.isDepthWriteEnabled = true
        
        guard let state = device.makeDepthStencilState(descriptor: depthDescriptor) else {
            throw RendererSetupError.depthStateCreationFailed
        }
        
        depthState = state
        scene = try SceneResources(device: device, queue: queue)
    }
}
