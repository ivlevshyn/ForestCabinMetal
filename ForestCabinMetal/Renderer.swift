//
//  Renderer.swift
//  ForestCabinMetal
//
//  Created by Ivan Levshyn on 02/10/2026.
//

import Foundation
import MetalKit

class Renderer: NSObject, MTKViewDelegate{
    func draw(in view: MTKView){
        print("Draw requested!")
    }
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        print("New size: \(size)")
    }
}
