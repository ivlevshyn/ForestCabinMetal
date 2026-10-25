import Foundation
import Metal
import simd

final class SceneObject {
    let mesh: MeshBuffers
    var model: simd_float4x4
    var baseColor: SIMD4<Float>
    let uniforms: any MTLBuffer

    init(
        mesh: MeshBuffers,
        model: simd_float4x4 = matrix_identity_float4x4,
        baseColor: SIMD4<Float> = SIMD4<Float>(1, 1, 1, 1),
        device: any MTLDevice,
        label: String
    ) throws {
        self.mesh = mesh
        self.model = model
        self.baseColor = baseColor

        guard let buffer = device.makeBuffer(
            length: MemoryLayout<GPUUniforms>.stride,
            options: .storageModeShared
        ) else {
            throw RendererSetupError.bufferCreationFailed(label + " uniforms")
        }

        buffer.label = label + " uniforms"
        uniforms = buffer
    }

    func writeUniforms(
        view: simd_float4x4,
        projection: simd_float4x4
    ) {
        var data = GPUUniforms(
            model: model,
            view: view,
            projection: projection,
            baseColor: baseColor
        )

        withUnsafeBytes(of: &data, { bytes in
            uniforms
                .contents()
                .copyMemory(from: bytes.baseAddress!, byteCount: bytes.count)
        })
    }
}
