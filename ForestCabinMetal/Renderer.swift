//
//  Renderer.swift
//  ForestCabinMetal
//
//  Created by Ivan Levshyn on 02/10/2026.
//

import Foundation
import MetalKit
import QuartzCore

enum RendererSetupError: Error{
    case commandBufferCreationFailed
    case sharedEventCreationFailed
    case metalLayerUnavailable
    case defaultLibraryUnavailable
}

class Renderer: NSObject, MTKViewDelegate{
    
    private var completionEvent: (any MTLSharedEvent)?
    private var lastSubmittedValue: UInt64? = nil
    private var commandBuffer: (any MTL4CommandBuffer)?
    private var commandAllocator: (any MTL4CommandAllocator)?
    private var inFlightDrawable: (any CAMetalDrawable)?
    private var flatTrianglePipeline: (any MTLRenderPipelineState)?
    private var colorTrianglePipeline: (any MTLRenderPipelineState)?
    
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
        encoder.drawPrimitives(primitiveType: .triangle, vertexStart: 0, vertexCount: 3)
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
    }
}
