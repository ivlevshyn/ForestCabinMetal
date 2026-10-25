import Foundation
import Metal
import simd

private func upload<T>(
    _ values: [T],
    device: any MTLDevice,
    label: String
) throws -> any MTLBuffer {
    guard !values.isEmpty else {
        throw RendererSetupError.invalidGeometry
    }

    let byteCount = values.count * MemoryLayout<T>.stride

    let buffer = try values.withUnsafeBufferPointer { pointer in
        guard let source = pointer.baseAddress,
              let buffer = device.makeBuffer(
                bytes: source,
                length: byteCount,
                options: .storageModeShared
              ) else {
            throw RendererSetupError.bufferCreationFailed(label)
        }

        return buffer

    }

    buffer.label = label
    return buffer
}

struct MeshBuffers {
    let vertices: any MTLBuffer
    let indices: any MTLBuffer
    let indexCount: Int

    init(
        _ data: MeshData,
        device: any MTLDevice,
        label: String
    ) throws {
        guard !data.vertices.isEmpty,
              !data.indices.isEmpty,
              data.indices.count.isMultiple(of: 3),
              data.indices.allSatisfy({
                  Int($0) < data.vertices.count
              }) else {
            throw RendererSetupError.invalidGeometry
        }

        vertices = try upload(data.vertices,
                              device: device,
                              label: label + " vertices"
        )

        indices = try upload(data.indices,
                             device: device,
                             label: label + " indices"
        )

        indexCount = data.indices.count
    }
}
