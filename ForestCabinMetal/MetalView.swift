import Foundation
import SwiftUI
import MetalKit

struct MetalView : NSViewRepresentable {
    
    var animationPaused: Bool = false
    var resetID: Int = 0
    var sceneActive: Bool = true
    var cameraPreset: OrbitCamera.Preset = .baseline
    var cameraRequestID: Int = 0

    func makeNSView(context: Context) -> MTKView{
        let view = CameraMTKView(
            frame: .zero,
            device: MTLCreateSystemDefaultDevice()
        )

        let renderer = context.coordinator

        view.onOrbit = { [weak renderer] horizontal, vertical in
            renderer?.orbitCamera(horizontal: horizontal, vertical: vertical)
        }

        view.onZoom = { [weak renderer] scroll in
            renderer?.zoomCamera(scroll: scroll)
        }

        view.isPaused = true
        view.enableSetNeedsDisplay = false
        view.preferredFramesPerSecond = 60
        view.delegate = context.coordinator
        
        guard let device = view.device else{
            print("Cannot prepare renderer: no Metal device.")
            return view
        }
        
        view.colorPixelFormat = .bgra8Unorm_srgb
        view.depthStencilPixelFormat = .depth32Float
        view.depthStencilStorageMode = .private
        view.sampleCount = 1
        view.clearDepth = 1
        view.autoResizeDrawable = true
        
        do {
            try context.coordinator.prepare(device: device, view: view)
            
            context.coordinator.setAnimationControls(paused: animationPaused, resetID: resetID, sceneActive: sceneActive)

            context.coordinator
                .setCameraPreset(cameraPreset, requestID: cameraRequestID)

            view.isPaused = false
        } catch {
            print("Cannot prepare renderer: \(error)")
        }
        
        return view
    }
    
    func updateNSView(_ nsView: MTKView, context: Context){
        context.coordinator.setAnimationControls(paused: animationPaused, resetID: resetID, sceneActive: sceneActive)

        context.coordinator
            .setCameraPreset(cameraPreset, requestID: cameraRequestID)
    }
    
    func makeCoordinator() -> Renderer {
        Renderer()
    }
}


