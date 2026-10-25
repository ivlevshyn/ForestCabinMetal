import Foundation
import Metal
import simd

final class SceneResources {
    let objects: [SceneObject]
    let arguments: any MTL4ArgumentTable
    let residencySet: any MTLResidencySet

    init(
        device: any MTLDevice,
        queue: any MTL4CommandQueue
    ) throws {
        try verifyGPULayouts()

        let boxMesh = try MeshBuffers(
            makeBoxMesh(),
            device: device,
            label: "Shared box"
        )

        let roofMesh = try MeshBuffers(
            makeRoofMesh(),
            device: device,
            label: "Roof prism"
        )

        let groundMesh = try MeshBuffers(
            makeGroundMesh(),
            device: device,
            label: "Ground"
        )

        let cabinRoot = makeTranslation([0.5, 0, -0.3])
        * makeScale([0.85, 0.85, 0.85])

        let cabin = try makeCabinObjects(
            boxMesh: boxMesh,
            roofMesh: roofMesh,
            rootTransform: cabinRoot,
            device: device
        )

        let ground = try SceneObject(
            mesh: groundMesh,
            baseColor: [0.12, 0.24, 0.10, 1],
            device: device,
            label: "Ground"
        )
        objects = cabin + [ground]

        let tableDescriptor = MTL4ArgumentTableDescriptor()
        tableDescriptor.maxBufferBindCount = 2
        tableDescriptor.maxTextureBindCount = 0
        tableDescriptor.maxSamplerStateBindCount = 0
        arguments = try device.makeArgumentTable(descriptor: tableDescriptor)

        let meshes = [boxMesh, groundMesh]
        let residencyDescriptor = MTLResidencySetDescriptor()
        residencyDescriptor.label = "Scene buffers"
        residencyDescriptor.initialCapacity = meshes.count * 2 + objects.count
        residencySet = try device
            .makeResidencySet(descriptor: residencyDescriptor)

        for mesh in meshes {
            residencySet.addAllocation(mesh.vertices)
            residencySet.addAllocation(mesh.indices)
        }
        for object in objects {
            residencySet.addAllocation(object.uniforms)
        }

        residencySet.commit()
        queue.addResidencySet(residencySet)
    }
}
