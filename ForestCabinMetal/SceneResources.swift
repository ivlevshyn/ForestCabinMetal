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

final class SceneResources {
    let box: MeshBuffers
    let ground: MeshBuffers
    
    let boxUniforms: any MTLBuffer
    let groundUniforms: any MTLBuffer
    
    let arguments: any MTL4ArgumentTable
    let residencySet: any MTLResidencySet
    
    init(
        device: any MTLDevice,
        queue: any MTL4CommandQueue
    ) throws {
        try verifyGPULayouts()
        
        box = try MeshBuffers(
            makeBoxMesh(),
            device: device,
            label: "Cabin box"
        )
        
        ground = try MeshBuffers(
            makeGroundMesh(),
            device: device,
            label: "Ground"
        )
        
        let length = MemoryLayout<GPUUniforms>.stride
        
        guard let boxBuffer = device.makeBuffer(
            length: length, options: .storageModeShared
        ),
        let groundBuffer = device.makeBuffer(
                length: length, options: .storageModeShared
        ) else {
            throw RendererSetupError.bufferCreationFailed("object uniforms")
        }
        
        boxBuffer.label = "Cabin box uniforms"
        groundBuffer.label = "Ground uniforms"
        
        boxUniforms = boxBuffer
        groundUniforms = groundBuffer
        
        let tableDescriptor = MTL4ArgumentTableDescriptor()
        tableDescriptor.maxBufferBindCount = 2
        tableDescriptor.maxTextureBindCount = 0
        tableDescriptor.maxSamplerStateBindCount = 0
        
        arguments = try device.makeArgumentTable(descriptor: tableDescriptor)
        
        let residencyDescriptor = MTLResidencySetDescriptor()
        residencyDescriptor.label = "Scene buffers"
        residencyDescriptor.initialCapacity = 6
        
        residencySet = try device.makeResidencySet(descriptor: residencyDescriptor)
        
        for buffer in [
            box.vertices, box.indices,
            ground.vertices, ground.indices,
            boxUniforms, groundUniforms
        ] {
            residencySet.addAllocation(buffer)
        }
        
        residencySet.commit()
        queue.addResidencySet(residencySet)
    }
    
    func writeUniforms (
        model: simd_float4x4,
        view: simd_float4x4,
        projection: simd_float4x4,
        to buffer: any MTLBuffer
    ) {
        var uniforms = GPUUniforms(model: model, view: view, projection: projection)
        
        withUnsafeBytes(of: &uniforms) { bytes in
            buffer.contents().copyMemory(from: bytes.baseAddress!, byteCount: bytes.count)
        }
    }
}
