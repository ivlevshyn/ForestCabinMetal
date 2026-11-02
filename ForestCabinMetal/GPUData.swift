import Foundation
import simd

struct GPUVertex{
    var position: SIMD4<Float>
    var color: SIMD4<Float>
    var normal: SIMD4<Float>
}

struct GPUUniforms{
    var model: simd_float4x4
    var view: simd_float4x4
    var projection: simd_float4x4
    var baseColor: SIMD4<Float>
    var normalMatrix: simd_float3x3
    var sunDirectionAndAmbient: SIMD4<Float>
    var sunColorAndIntensity: SIMD4<Float>
}

func verifyGPULayouts() throws {
    guard MemoryLayout<GPUVertex>.size == 48,
          MemoryLayout<GPUVertex>.stride == 48,
          MemoryLayout<GPUVertex>.alignment == 16,
          MemoryLayout<GPUVertex>.offset(of: \.position) == 0,
          MemoryLayout<GPUVertex>.self.offset(of: \.color) == 16,
          MemoryLayout<GPUVertex>.self.offset(of: \.normal) == 32
            else {
        throw RendererSetupError.vertexLayoutMismatch
    }
    
    guard MemoryLayout<GPUUniforms>.size == 288,
          MemoryLayout<GPUUniforms>.stride == 288,
          MemoryLayout<GPUUniforms>.alignment == 16,
          MemoryLayout<GPUUniforms>.offset(of: \.model) == 0,
          MemoryLayout<GPUUniforms>.offset(of: \.view) == 64,
          MemoryLayout<GPUUniforms>.offset(of: \.projection) == 128,
          MemoryLayout<GPUUniforms>.offset(of: \.baseColor) == 192,
          MemoryLayout<GPUUniforms>.offset(of: \.normalMatrix) == 208,
          MemoryLayout<GPUUniforms>.offset(of: \.sunDirectionAndAmbient) == 256,
          MemoryLayout<GPUUniforms>.offset(of: \.sunColorAndIntensity) == 272
    else {
        throw RendererSetupError.uniformLayoutMismatch
    }
}
