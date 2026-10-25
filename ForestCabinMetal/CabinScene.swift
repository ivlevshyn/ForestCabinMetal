import Foundation
import Metal
import simd

func makeCabinObjects(
    boxMesh: MeshBuffers,
    roofMesh: MeshBuffers,
    rootTransform: simd_float4x4 = matrix_identity_float4x4,
    device: any MTLDevice
) throws -> [SceneObject] {
    func box(
        _ label: String,
        center: SIMD3<Float>,
        size: SIMD3<Float>,
        color: SIMD4<Float>
    ) throws -> SceneObject {
        return try SceneObject(
            mesh: boxMesh,
            model: rootTransform * makeTranslation(center) * makeScale(size),
            device: device,
            label: label
        )
    }

    return [
        try box(
            "Cabin body",
            center: [0, 1.2, 0],
            size: [3, 2.4, 2.6],
            color: [0.55, 0.24, 0.10, 1]
        ),
        try SceneObject(
            mesh: roofMesh,
            model: rootTransform * makeTranslation([0, 2.9, 0])
            * makeScale([3.4, 1, 3]),
            baseColor: [0.16, 0.10, 0.08, 1],
            device: device,
            label: "Cabin roof"
        ),
        try box(
            "Porch deck",
            center: [0, 0.1, 1.8],
            size: [3, 0.2, 1],
            color: [0.32, 0.18, 0.09, 1]
        ),
        try box(
            "Porch canopy",
            center: [0, 2.46, 1.8],
            size: [3.1, 0.12, 1.1],
            color: [0.18, 0.12, 0.08, 1]
        ),
        try box(
            "Left porch post",
            center: [-1.35, 1.3, 2.16],
            size: [0.12, 2.2, 0.12],
            color: [0.35, 0.19, 0.10, 1]
        ),
        try box(
            "Right porch post",
            center: [1.35, 1.3, 2.16],
            size: [0.12, 2.2, 0.12],
            color: [0.35, 0.19, 0.10, 1]
        ),
        try box(
            "Door panel",
            center: [0, 1.1, 1.32],
            size: [0.8, 1.8, 0.06],
            color: [0.22, 0.10, 0.05, 1]
        ),
        try box(
            "Left window panel",
            center: [-0.95, 1.55, 1.32],
            size: [0.65, 0.65, 0.06],
            color: [0.16, 0.36, 0.48, 1]
        ),
        try box(
            "Right window panel",
            center: [0.95, 1.55, 1.32],
            size: [0.65, 0.65, 0.06],
            color: [0.16, 0.36, 0.48, 1]
        ),
        try box(
            "Chimney",
            center: [0.8, 3.25, -0.55],
            size: [0.35, 1.3, 0.35],
            color: [0.30, 0.31, 0.32, 1]
        )
    ]
}
