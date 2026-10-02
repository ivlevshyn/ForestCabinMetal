//
//  Renderer.swift
//  ForestCabinMetal
//
//  Created by Ivan Levshyn on 02/10/2026.
//

import Foundation
import MetalKit

enum RendererSetupError: Error{
    case commandBufferCreationFailed
    case sharedEventCreationFailed
}

class Renderer: NSObject, MTKViewDelegate{
    
    private var completionEvent: (any MTLSharedEvent)?
    private var lastSubmittedValue: UInt64? = nil
    private var commandBuffer: (any MTL4CommandBuffer)?
    private var commandAllocator: (any MTL4CommandAllocator)?
    
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
        
        print("Frame slot available")
        
        guard view.drawableSize.width > 0,
              view.drawableSize.height > 0 else {
            print("Frame skipped: zero drawable size")
            return
        }
        
        guard let passDescriptor = view.currentRenderPassDescriptor,
              let drawable = view.currentDrawable else {
            print("Frame skipped drawable or pass unavailable")
            return
        }
        
        print("Drawable: \(drawable.texture.width) * \(drawable.texture.height)")
        print("Color target exists: \(passDescriptor.colorAttachments[0].texture != nil)")
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        print("New size: \(size)")
    }
    
    private var commandQueue: (any MTL4CommandQueue)?
    
    func prepare(device: any MTLDevice) throws {
        
        let descriptor = MTL4CommandQueueDescriptor()
        descriptor.label = "Forest cabin queue"
        
        commandQueue = try device.makeMTL4CommandQueue(descriptor: descriptor)
        
        print("Metal 4 queue ready")
        
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
    }
}
