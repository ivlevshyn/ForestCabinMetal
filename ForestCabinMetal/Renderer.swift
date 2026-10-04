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

enum RendererSetupError: Error{
    case commandBufferCreationFailed
    case sharedEventCreationFailed
    case metalLayerUnavailable
    case defaultLibraryUnavailable
    case vertexLayoutMismatch
    case invalidGeometry
    case bufferCreationFailed(String)
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
    
    private var vertexCount = 0
    private var indexCount = 0
    
    private let useInterpolatedColor = true
    
    func draw(in view: MTKView){
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
        
        guard let arguments = meshArguments, meshVertexBuffer != nil, vertexCount > 0 else {
            print("Frame skipped: geometry unavailable")
            return
        }
        
        let colorTarget = passDescriptor.colorAttachments[0]!
        colorTarget.loadAction = .clear
        colorTarget.storeAction = .store
        colorTarget.clearColor = MTLClearColor(
            red: 0.16, green: 0.35, blue: 0.55, alpha: 1.0
        )
        
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
        encoder.setArgumentTable(arguments, stages: .vertex)
        
        if let indices = meshIndexBuffer {
            let indexByteOffset = 0
            
            encoder.drawIndexedPrimitives(primitiveType: .triangle,
                                          indexCount: indexCount,
                                          indexType: .uint16,
                                          indexBuffer: indices.gpuAddress + UInt64(indexByteOffset),
                                          indexBufferLength: indices.length - indexByteOffset)
        } else {
            encoder.drawPrimitives(primitiveType: .triangle,
                                   vertexStart: 0,
                                   vertexCount: vertexCount)
        }
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
        let leftPanel = makePanelVertices(xMin: -0.90, xMax: -0.10, yMin: -0.45, yMax: 0.45)
        
        let rightPanel = makePanelVertices(xMin: 0.20, xMax: 0.90, yMin: -0.65, yMax: 0.65)
        
        let vertices = leftPanel + rightPanel
        
        let indices: [UInt16] = [
            0, 1, 2,
            0, 2, 3,
            
            4, 5, 6,
            4, 6, 7
        ]
        
        return (vertices: vertices, indices: indices)
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
        
        let residencyDesciptor = MTLResidencySetDescriptor()
        residencyDesciptor.label = "Lesson 03 geometry residency"
        residencyDesciptor.initialCapacity = 2
        
        let residencySet = try device.makeResidencySet(descriptor: residencyDesciptor)
        
        residencySet.addAllocation(vertexBuffer)
        
        if let indexBuffer {
            residencySet.addAllocation(indexBuffer)
        }
        
        residencySet.commit()
        
        let argumentDescriptor = MTL4ArgumentTableDescriptor()
        argumentDescriptor.label = "Lesson 03 vertec arguments"
        argumentDescriptor.maxBufferBindCount = 1
        argumentDescriptor.maxTextureBindCount = 0
        argumentDescriptor.maxSamplerStateBindCount = 0
        
        let arguments = try device.makeArgumentTable(descriptor: argumentDescriptor)
        
        arguments.setAddress(vertexBuffer.gpuAddress, index: 0)
        
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
