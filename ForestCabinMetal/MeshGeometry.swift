import Foundation
import simd

struct MeshData {
    var vertices: [GPUVertex] = []
    var indices: [UInt16] = []
    
    mutating func addQuad(
        _ a: SIMD3<Float>,
        _ b: SIMD3<Float>,
        _ c: SIMD3<Float>,
        _ d: SIMD3<Float>,
        color: SIMD4<Float>
    ) {
        precondition(vertices.count <= Int(UInt16.max) - 3)
        let base = UInt16(vertices.count)
        
        for p in [a, b, c, d] {
            vertices.append(GPUVertex(
                position: SIMD4<Float>(p.x, p.y, p.z, 1),
                color: color))
        }
        
        indices += [
            base, base + 1, base + 2,
            base, base + 2, base + 3
        ]
    }
}

func makeBoxMesh() -> MeshData {
    var mesh = MeshData()
    
    //Counterclockwise
    
    mesh.addQuad(
        [-0.5, -0.5, 0.5],
        [0.5, -0.5, 0.5],
        [0.5, 0.5, 0.5],
        [-0.5, 0.5, 0.5],
        color: [0.8, 0.2, 0.1, 1]
    ) // +Z
    
    mesh.addQuad(
        [0.5, -0.5, -0.5],
        [-0.5, -0.5, -0.5],
        [-0.5, 0.5, -0.5],
        [0.5, 0.5, -0.5],
        color: [0.1, 0.6, 0.8, 1]
    ) // -Z
    
    mesh.addQuad(
        [0.5, -0.5, 0.5],
        [0.5, -0.5, -0.5],
        [0.5, 0.5, -0.5],
        [0.5, 0.5, 0.5],
        color: [0.2, 0.7, 0.2, 1]
    ) // +X
    
    mesh.addQuad(
        [-0.5, -0.5, -0.5],
        [-0.5, -0.5, 0.5],
        [-0.5, 0.5, 0.5],
        [-0.5, 0.5, -0.5],
        color: [0.7, 0.2, 0.7, 1]
    ) // -X
    
    mesh.addQuad(
        [-0.5, 0.5, 0.5],
        [0.5, 0.5, 0.5],
        [0.5, 0.5, -0.5],
        [-0.5, 0.5, -0.5],
        color: [0.9, 0.7, 0.15, 1]
    ) // +Y
    
    mesh.addQuad(
        [-0.5, -0.5, 0.5],
        [0.5, -0.5, 0.5],
        [0.5, 0.5, 0.5],
        [-0.5, 0.5, 0.5],
        color: [0.25, 0.25, 0.3, 1]
    ) // -Y
    
    return mesh
}

func makeGroundMesh() -> MeshData {
    var mesh = MeshData()
    
    mesh.addQuad(
        [-3, 0, 3],
        [3, 0, 3],
        [3, 0, -3],
        [-3, 0, -3],
        color: [0.12, 0.24, 0.10, 1]
    )
    
    return mesh
}
