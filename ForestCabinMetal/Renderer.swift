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
}

class Renderer: NSObject, MTKViewDelegate{
    
    func draw(in view: MTKView){
        print("Draw requested!")
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
    }
    
    private var commandBuffer: (any MTL4CommandBuffer)?
    private var commandAllocator: (any MTL4CommandAllocator)?
}
