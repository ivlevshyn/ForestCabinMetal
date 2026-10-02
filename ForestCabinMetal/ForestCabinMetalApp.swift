//
//  ForestCabinMetalApp.swift
//  ForestCabinMetal
//
//  Created by Ivan Levshyn on 02/10/2026.
//

import SwiftUI
import Metal

@main
struct ForestCabinMetalApp: App {
    init(){
        guard let device = MTLCreateSystemDefaultDevice() else {
            print("No Metal device deected!")
            return
        }
        
        print("GPU: \(device.name)")
        
        let supportsMetal4 = device.supportsFamily(.metal4)
        print("Metal 4 supported: \(supportsMetal4)")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
