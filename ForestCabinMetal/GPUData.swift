import Foundation
import simd

struct GPUVertex{
    var position: SIMD4<Float>
    var color: SIMD4<Float>
}

struct GPUUniforms{
    var model: simd_float4x4
    var view: simd_float4x4
    var projection: simd_float4x4
}

func verifyGPULayouts() throws {
    guard MemoryLayout<GPUVertex>.size == 32,
          MemoryLayout<GPUVertex>.stride == 32,
          MemoryLayout<GPUVertex>.alignment == 16,
          MemoryLayout<GPUVertex>.offset(of: \.position) == 0,
          MemoryLayout<GPUVertex>.self.offset(of: \.color) == 16
            else {
        throw RendererSetupError.vertexLayoutMismatch
    }
    
    guard MemoryLayout<GPUUniforms>.size == 192,
          MemoryLayout<GPUUniforms>.stride == 192,
          MemoryLayout<GPUUniforms>.alignment == 16,
          MemoryLayout<GPUUniforms>.offset(of: \GPUUniforms.model) == 0,
          MemoryLayout<GPUUniforms>.offset(of: \GPUUniforms.view) == 64,
          MemoryLayout<GPUUniforms>.offset(of: \GPUUniforms.projection) == 128 else {
        throw RendererSetupError.uniformLayoutMismatch
    }
}
