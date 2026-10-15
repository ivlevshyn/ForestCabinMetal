import Foundation
import simd

func makeScale(_ scale: SIMD3<Float>) -> simd_float4x4 {
    simd_float4x4(columns:(
        SIMD4<Float>(scale.x, 0, 0, 0),
        SIMD4<Float>(0, scale.y, 0, 0),
        SIMD4<Float>(0, 0, scale.z, 0),
        SIMD4<Float>(0, 0, 0, 1)
    ))
}

func makeTranslation(_ translation: SIMD3<Float>) -> simd_float4x4 {
    simd_float4x4(columns:(
        SIMD4<Float>(1, 0, 0, 0),
        SIMD4<Float>(0, 1, 0, 0),
        SIMD4<Float>(0, 0, 1, 0),
        SIMD4<Float>(translation.x, translation.y, translation.z, 1)
    ))
}

func makeRotationZ(_ radians: Float) -> simd_float4x4 {
    let c = cos(radians)
    let s = sin(radians)
    return simd_float4x4(columns:(
        SIMD4<Float>(c, s, 0, 0),
        SIMD4<Float>(-s, c, 0, 0),
        SIMD4<Float>(0, 0, 1, 0),
        SIMD4<Float>(0, 0, 0, 1)
    ))
}

func makeRotationX(_ radians: Float) -> simd_float4x4 {
    let c = cos(radians)
    let s = sin(radians)
    
    return simd_float4x4(columns:(
        SIMD4<Float>(1, 0, 0, 0),
        SIMD4<Float>(0, c, s, 0),
        SIMD4<Float>(0, -s, c, 0),
        SIMD4<Float>(0, 0, 0, 1)
    ))
}

func makeRotationY(_ radians: Float) -> simd_float4x4 {
    let c = cos(radians)
    let s = sin(radians)
    
    return simd_float4x4(columns:(
        SIMD4<Float>(c, 0, -s, 0),
        SIMD4<Float>(0, 1, 0, 0),
        SIMD4<Float>(s, 0, c, 0),
        SIMD4<Float>(0, 0, 0, 1)
    ))
}

func makePerspective(
    verticalFOV: Float,
    aspect: Float,
    near: Float,
    far: Float
) -> simd_float4x4 {
    precondition(verticalFOV > 0 && verticalFOV < .pi)
    precondition(aspect > 0 && near > 0 && far > near)
    
    let yScale = 1 / tan(verticalFOV / 2)
    let xScale = yScale / aspect
    let a = far / (near - far)
    let b = near * far / (near - far)
    
    return simd_float4x4(columns:(
        SIMD4<Float>(xScale, 0, 0, 0),
        SIMD4<Float>(0, yScale, 0, 0),
        SIMD4<Float>(0, 0, a, -1),
        SIMD4<Float>(0, 0, b, 0)
    ))
}

func verifyProjectionMath() {
    let near: Float = 0.1
    let far: Float = 30
    
    let p = makePerspective(verticalFOV: .pi / 3, aspect: 1, near: near, far: far)
    
    let nearClip = p * SIMD4<Float>(0, 0, -near, 1)
    let farClip = p * SIMD4<Float>(0, 0, -far, 1)
    
    assert(abs(nearClip.z / nearClip.w) < 0.0001)
    assert(abs(farClip.z / farClip.w - 1) < 0.0001)
    
    let close = p * SIMD4<Float>(1, 0, -2, 1)
    let distant = p * SIMD4<Float>(1, 0, -4, 1)
    
    assert(
        abs(
            close.x / close.w
            - 2 * (distant.x / distant.w)
        ) < 0.0001
    )
}
