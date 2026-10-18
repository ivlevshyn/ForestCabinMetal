import Foundation
import AppKit
import MetalKit

final class CameraMTKView: MTKView {
    var onOrbit: ((Float, Float) -> Void)?
    var onZoom: ((Float) -> Void)?

    override var acceptsFirstResponder: Bool {
        true
    }
    
    override func mouseDown(with event: NSEvent) {
        window?.makeFirstResponder(self)
    }

    override func mouseDragged(with event: NSEvent) {
        guard window?.isKeyWindow == true else {
            return
        }

        onOrbit?(
            Float(event.deltaX),
            Float(-event.deltaY)
        )
    }

    override func scrollWheel(with event: NSEvent) {
        guard window?.isKeyWindow == true else {
            return
        }

        let unitScale: CGFloat = event.hasPreciseScrollingDeltas ? 1 : 20

        onZoom?(
            Float(event.scrollingDeltaY * unitScale)
        )
    }
}
