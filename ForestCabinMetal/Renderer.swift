//
//  Renderer.swift
//  ForestCabinMetal
//
//  Created by Ivan Levshyn on 02/10/2026.
//

import Foundation
import MetalKit
import QuartzCore
import simd

struct GPUVertex{
    var position: SIMD4<Float>
    var color: SIMD4<Float>
}

struct GPUUniforms{
    var model: simd_float4x4
}

private func makeScale(_ scale: SIMD3<Float>) -> simd_float4x4 {
    simd_float4x4(columns:(
                  SIMD4<Float>(scale.x, 0, 0, 0),
                  SIMD4<Float>(0, scale.y, 0, 0),
                  SIMD4<Float>(0, 0, scale.z, 0),
                  SIMD4<Float>(0, 0, 0, 1)
    ))
}

private func makeTranslation(_ translation: SIMD3<Float>) -> simd_float4x4 {
    simd_float4x4(columns:(
        SIMD4<Float>(1, 0, 0, 0),
        SIMD4<Float>(0, 1, 0, 0),
        SIMD4<Float>(0, 0, 1, 0),
        SIMD4<Float>(translation.x, translation.y, translation.z, 1)
    ))
}

private func makeRotationZ(_ radians: Float) -> simd_float4x4 {
    let c = cos(radians)
    let s = sin(radians)
    return simd_float4x4(columns:(
        SIMD4<Float>(c, s, 0, 0),
        SIMD4<Float>(-s, c, 0, 0),
        SIMD4<Float>(0, 0, 1, 0),
        SIMD4<Float>(0, 0, 0, 1)
    ))
}

enum RendererSetupError: Error{
    case commandBufferCreationFailed
    case sharedEventCreationFailed
    case metalLayerUnavailable
    case defaultLibraryUnavailable
    case vertexLayoutMismatch
    case invalidGeometry
    case bufferCreationFailed(String)
    case uniformLayoutMismatch
}

class Renderer: NSObject, MTKViewDelegate{
    
    private var completionEvent: (any MTLSharedEvent)?
    private var lastSubmittedValue: UInt64? = nil
    private var commandBuffer: (any MTL4CommandBuffer)?
    private var commandAllocator: (any MTL4CommandAllocator)?
    private var inFlightDrawable: (any CAMetalDrawable)?
    private var flatTrianglePipeline: (any MTLRenderPipelineState)?
    private var colorTrianglePipeline: (any MTLRenderPipelineState)?
    private var meshVertexBuffer: (any MTLBuffer)?
    private var meshIndexBuffer: (any MTLBuffer)?
    private var meshArguments: (any MTL4ArgumentTable)?
    private var meshResidencySet: (any MTLResidencySet)?
    private var wallUniformBuffer: (any MTLBuffer)?
    private var roofUniformBuffer: (any MTLBuffer)?
    private var animationTime: TimeInterval = 0
    private var previousAnimationSample: CFTimeInterval?
    
    private var animationPaused = false
    private var animationSceneActive = true
    private var lastResetID = 0
    
    private var vertexCount = 0
    private var indexCount = 0
    
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
    
    private func writeObjectUniforms(
        wallBuffer: any MTLBuffer,
        roofBuffer: any MTLBuffer
    ) {
        let sway = Float(0.15 * sin(0.8 * animationTime))
        
        let wallModel = makeTranslation(SIMD3<Float>(-0.48, -0.05, 0)) *
        makeRotationZ(0) *
        makeScale(SIMD3<Float>(0.58, 0.70, 1))
        
        let roofModel = makeTranslation(SIMD3<Float>(0.48, 0.08, 0)) *
        makeRotationZ(0.22 + sway) *
        makeScale(SIMD3<Float>(0.58, 0.70, 1))
        
        var wallUniforms = GPUUniforms(model: wallModel)
        var roofUniforms = GPUUniforms(model: roofModel)
        
        withUnsafeBytes(of: &wallUniforms) { bytes in
            wallBuffer.contents().copyMemory(from: bytes.baseAddress!, byteCount: bytes.count)
        }
        
        withUnsafeBytes(of: &roofUniforms) { bytes in
            roofBuffer.contents().copyMemory(from: bytes.baseAddress!, byteCount: bytes.count)
        }
    }
    
    func draw(in view: MTKView){
        updateAnimationTime()
        print("Draw requested!")
        
        guard let event = completionEvent else {
            print("Draw skipped: completion event unavailable")
            return
        }

        
        if let pendingValue = lastSubmittedValue {
            if event.signaledValue < pendingValue {
                print("Draw skipped: GPU still busy")
                return
            }
        }
        
        inFlightDrawable = nil
        
        print("Frame slot available")
        
        guard view.drawableSize.width > 0,
              view.drawableSize.height > 0 else {
            print("Frame skipped: zero drawable size")
            return
        }
        
        guard let passDescriptor = view.currentMTL4RenderPassDescriptor,
              let drawable = view.currentDrawable else {
            print("Frame skipped drawable or pass unavailable")
            return
        }
        
        print("Drawable: \(drawable.texture.width) * \(drawable.texture.height)")
        print("Color target exists: \(passDescriptor.colorAttachments[0].texture != nil)")
        
        guard let buffer = commandBuffer,
              let allocator = commandAllocator,
              let queue = commandQueue else {
            print("Frame skipped: command storage unavailable")
            return
        }
        
        let selectedPipeline = useInterpolatedColor
        ? colorTrianglePipeline
        : flatTrianglePipeline
        
        guard let pipeline = selectedPipeline else {
            print("Frame skipped: triangle pipeline unavailable")
            return
        }
        
        guard let arguments = meshArguments,
              meshVertexBuffer != nil,
              let indices = meshIndexBuffer,
              let wallUniforms = wallUniformBuffer,
              let roofUniforms = roofUniformBuffer,
              vertexCount > 0,
              indexCount > 0 else {
            print("Frame skipped: insufficient data")
            return
        }
        
        let colorTarget = passDescriptor.colorAttachments[0]!
        colorTarget.loadAction = .clear
        colorTarget.storeAction = .store
        colorTarget.clearColor = MTLClearColor(
            red: 0.16, green: 0.35, blue: 0.55, alpha: 1.0
        )
        
        writeObjectUniforms(wallBuffer: wallUniforms, roofBuffer: roofUniforms)
        
        allocator.reset()
        buffer.beginCommandBuffer(allocator: allocator)
        
        guard let encoder = buffer.makeRenderCommandEncoder(descriptor: passDescriptor, options: []) else {
            buffer.endCommandBuffer()
            
            print("Frame skipped: render encoder unavailable")
            return
        }
        
        encoder.label = "Triangle pass"
        encoder.setRenderPipelineState(pipeline)
        encoder.setFrontFacing(.counterClockwise)
        encoder.setCullMode(.none)
        
        arguments.setAddress(wallUniforms.gpuAddress, index: 1)
        encoder.setArgumentTable(arguments, stages: .vertex)
        
        encoder.drawIndexedPrimitives(primitiveType: .triangle, indexCount: indexCount, indexType: .uint16, indexBuffer: indices.gpuAddress, indexBufferLength: indices.length)
        
        arguments.setAddress(roofUniforms.gpuAddress, index: 1)
        encoder.setArgumentTable(arguments, stages: .vertex)
        
        encoder.drawIndexedPrimitives(primitiveType: .triangle, indexCount: indexCount, indexType: .uint16, indexBuffer: indices.gpuAddress, indexBufferLength: indices.length)
        
        encoder.endEncoding()
        
        buffer.endCommandBuffer()
        
        let submissionValue = (lastSubmittedValue ?? 0) + 1

        let commitOptions = MTL4CommitOptions()
        commitOptions.addFeedbackHandler {
            feedback in
            if let error = feedback.error {
                print("GPU submission failed: \(error)")
            }
        }
        
        inFlightDrawable = drawable
        
        queue.waitForDrawable(drawable)
        queue.commit([buffer], options: commitOptions)
        queue.signalDrawable(drawable)
        drawable.present()
        
        queue.signalEvent(event, value: submissionValue)
        lastSubmittedValue = submissionValue
        
        print("Submitted frame \(submissionValue)")
        
        print("Triangle pass submitted")
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
    
    private func makePanelVertices(
        xMin: Float,
        xMax: Float,
        yMin: Float,
        yMax: Float
    ) -> [GPUVertex] {
        [
            GPUVertex(position: SIMD4<Float>(xMin, yMin, 0.0, 1.0), color: SIMD4<Float>(1.0, 0.0, 0.0, 1.0)),
            GPUVertex(position: SIMD4<Float>(xMax, yMin, 0.0, 1.0), color: SIMD4<Float>(0.0, 1.0, 0.0, 1.0)),
            GPUVertex(position: SIMD4<Float>(xMax, yMax, 0.0, 1.0), color: SIMD4<Float>(0.0, 0.0, 1.0, 1.0)),
            GPUVertex(position: SIMD4<Float>(xMin, yMax, 0.0, 1.0), color: SIMD4<Float>(1.0, 1.0, 0.0, 1.0)),
        ]
    }
    
    private func makeGeometryData() -> (vertices: [GPUVertex], indices: [UInt16]?){
        let vertices = makePanelVertices(xMin: -0.5, xMax: 0.5, yMin: -0.5, yMax: 0.5)
        
        let indices: [UInt16] = [
            0, 1, 2,
            0, 2, 3
        ]
        
        return (vertices: vertices, indices: indices)
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
    
    private func verifyVertexLayout() throws {
        let size = MemoryLayout<GPUVertex>.size
        let stride = MemoryLayout<GPUVertex>.stride
        let alignment = MemoryLayout<GPUVertex>.alignment
        let positionOffset = MemoryLayout<GPUVertex>.offset(of: \GPUVertex.position)
        let colorOffset = MemoryLayout<GPUVertex>.offset(of: \GPUVertex.color)
        
        print("GPUVertex: size=\(size), stride=\(stride), alignment=\(alignment)")
        
        print("Offsets: position=\(String(describing: positionOffset))," + "color=\(String(describing: colorOffset))")
        
        guard size == 32,
              stride == 32,
              alignment == 16,
              positionOffset == 0,
              colorOffset == 16 else {
            throw RendererSetupError.vertexLayoutMismatch
        }
    }
    
    private func verifyUniformLayout() throws {
        let size = MemoryLayout<GPUUniforms>.size
        let stride = MemoryLayout<GPUUniforms>.stride
        let alignment = MemoryLayout<GPUUniforms>.alignment
        let modelOffset = MemoryLayout<GPUUniforms>.offset(of: \GPUUniforms.model)
        
        print("GPUUniforms: size = \(size), stride = \(stride), " + "alignment = \(alignment), modelOffset=\(String(describing: modelOffset))")
        
        guard size == 64,
              stride == 64,
              alignment == 16,
              modelOffset == 0 else {
            throw RendererSetupError.uniformLayoutMismatch
        }
    }
    
    private func prepareGeometry(
        device: any MTLDevice,
        queue: any MTL4CommandQueue
    ) throws {
        try verifyVertexLayout()
        
        let geometry = makeGeometryData()
        let vertices = geometry.vertices
        
        guard !vertices.isEmpty else {
            throw RendererSetupError.invalidGeometry
        }
        
        if let indices = geometry.indices {
            guard !indices.isEmpty,
                  indices.count.isMultiple(of: 3),
                  indices.allSatisfy({Int($0) < vertices.count}) else {
                throw RendererSetupError.invalidGeometry
            }
        }
        
        let vertexByteCount = vertices.count * MemoryLayout<GPUVertex>.stride
        
        let vertexBuffer = try vertices.withUnsafeBufferPointer{
            pointer -> any MTLBuffer in
            
            guard let source = pointer.baseAddress else {
                throw RendererSetupError.invalidGeometry
            }
            
            guard let buffer = device.makeBuffer(bytes: source, length: vertexByteCount, options: .storageModeShared) else {
                throw RendererSetupError.bufferCreationFailed("vertices")
            }
            
            return buffer
        }
        
        vertexBuffer.label = "Lesson 03 vertices"
        
        var indexBuffer: (any MTLBuffer)? = nil
        
        if let indices = geometry.indices {
            let indexByteCount = indices.count * MemoryLayout<UInt16>.stride
            
            let buffer = try indices.withUnsafeBufferPointer{
                pointer -> any MTLBuffer in
                
                guard let source = pointer.baseAddress else {
                    throw RendererSetupError.invalidGeometry
                }
                
                guard let buffer = device.makeBuffer(bytes: source, length: indexByteCount, options: .storageModeShared) else {
                    throw RendererSetupError.bufferCreationFailed("indices")
                }
                
                return buffer
            }
            
            buffer.label = "Lesson 03 indices"
            indexBuffer = buffer
        }
        
        try verifyUniformLayout()
        
        let uniformByteCount = MemoryLayout<GPUUniforms>.stride
        
        guard let wallUniforms = device.makeBuffer(length: uniformByteCount, options: .storageModeShared) else {
            throw RendererSetupError.bufferCreationFailed("wall uniforms")
        }
        
        guard let roofUniforms = device.makeBuffer(length: uniformByteCount, options: .storageModeShared) else {
            throw RendererSetupError.bufferCreationFailed("roof uniforms")
        }
        
        wallUniforms.label = "wall uniforms"
        roofUniforms.label = "roof uniforms"
        
        let residencyDesciptor = MTLResidencySetDescriptor()
        residencyDesciptor.label = "Lesson 03 geometry residency"
        residencyDesciptor.initialCapacity = 4
        
        let residencySet = try device.makeResidencySet(descriptor: residencyDesciptor)
        
        residencySet.addAllocation(vertexBuffer)
        
        if let indexBuffer {
            residencySet.addAllocation(indexBuffer)
        }
        
        residencySet.addAllocation(wallUniforms)
        residencySet.addAllocation(roofUniforms)
        
        residencySet.commit()
        
        let argumentDescriptor = MTL4ArgumentTableDescriptor()
        argumentDescriptor.label = "Lesson 03 vertec arguments"
        argumentDescriptor.maxBufferBindCount = 2
        argumentDescriptor.maxTextureBindCount = 0
        argumentDescriptor.maxSamplerStateBindCount = 0
        
        let arguments = try device.makeArgumentTable(descriptor: argumentDescriptor)
        
        arguments.setAddress(vertexBuffer.gpuAddress, index: 0)
        arguments.setAddress(wallUniforms.gpuAddress, index: 1)
        
        self.wallUniformBuffer = wallUniforms
        self.roofUniformBuffer = roofUniforms
        self.meshVertexBuffer = vertexBuffer
        self.meshIndexBuffer = indexBuffer
        self.meshArguments = arguments
        self.meshResidencySet = residencySet
        self.vertexCount = vertices.count
        self.indexCount = geometry.indices?.count ?? 0
        
        queue.addResidencySet(residencySet)
        
        print(
            "Geometry ready: \(vertexCount) vertices, " +
            "\(vertexBuffer.length) vertex bytes, " +
            "\(indexCount) indices, " +
            "\(indexBuffer?.length ?? 0) index bytes"
        )
    }
    
    func prepare(device: any MTLDevice, view: MTKView) throws {
        
        verifyTransformMath()
        
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
        
        try prepareGeometry(device: device, queue: queue)
    }
}
