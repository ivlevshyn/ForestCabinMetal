//
//  MetalView.swift
//  ForestCabinMetal
//
//  Created by Ivan Levshyn on 02/10/2026.
//

import Foundation
import SwiftUI
import MetalKit

struct MetalView:NSViewRepresentable{
    func makeNSView(context: Context) -> MTKView{
        let MetalView = MTKView(frame: .zero, device: MTLCreateSystemDefaultDevice())
        MetalView.isPaused = true
        MetalView.enableSetNeedsDisplay = false
        print("MTKView created!")
        return MetalView
    }
    func updateNSView(_ nsView: MTKView, context: Context){}
}


