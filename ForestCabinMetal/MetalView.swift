//
//  MetalView.swift
//  ForestCabinMetal
//
//  Created by Ivan Levshyn on 02/10/2026.
//

import Foundation
import SwiftUI
import MetalKit

struct MetalView : NSViewRepresentable {
    
    var animationPaused: Bool = false
    var resetID: Int = 0
    var sceneActive: Bool = true
    
    func makeNSView(context: Context) -> MTKView{
        let view = MTKView(
            frame: .zero,
            device: MTLCreateSystemDefaultDevice()
        )
        
        view.isPaused = true
        view.enableSetNeedsDisplay = false
        view.preferredFramesPerSecond = 60
        view.delegate = context.coordinator
        
        guard let device = view.device else{
            print("Cannot prepare renderer: no Metal device.")
            return view
        }
        
        view.colorPixelFormat = .bgra8Unorm_srgb
        
        do {
            try context.coordinator.prepare(device: device, view: view)
            
            context.coordinator.setAnimationControls(paused: animationPaused, resetID: resetID, sceneActive: sceneActive)
            
            view.isPaused = false
        } catch {
            print("Cannot prepare renderer: \(error)")
        }
        
        return view
    }
    
    func updateNSView(_ nsView: MTKView, context: Context){
        context.coordinator.setAnimationControls(paused: animationPaused, resetID: resetID, sceneActive: sceneActive)
    }
    
    func makeCoordinator() -> Renderer {
        Renderer()
    }
}


