import Foundation
import simd

struct OrbitCamera {

    enum Preset: String, CaseIterable {
        case baseline = "Baseline"
        case side = "Side"
        case elevated = "Elevated"
    }

    private(set) var target = SIMD3<Float>(0, 1.7, 0)
    private(set) var distance: Float = 8
    private(set) var yaw: Float = 0
    private(set) var pitch: Float = atan2(Float(1.75), Float(6))

    var eye: SIMD3<Float> {
        let horizontalDistance = distance * cos(pitch)

        let offset = SIMD3<Float>(
            horizontalDistance * sin(yaw),
            distance * sin(pitch),
            horizontalDistance * cos(yaw)
        )

        return target + offset
    }

    var viewMatrix: simd_float4x4 {
        makeLookAt(eye: eye, target: target)
    }

    mutating func orbit(horizontal: Float, vertical: Float) {
        let sensitivity: Float = 0.005

        yaw += horizontal * sensitivity
        yaw = yaw.truncatingRemainder(dividingBy: 2 * Float.pi)

        pitch += vertical * sensitivity
        pitch = min (max(pitch, 0.05), Float.pi / 2 - 0.05)
    }

    mutating func zoom(scroll: Float) {
        let exponent = min(max(-scroll * 0.01, -1), 1)

        distance *= exp(exponent)
        distance = min(max(distance, 2), 12)
    }

    mutating func apply(_ preset: Preset) {
        reset()

        switch preset {
        case .baseline:
            break
        case .side:
            yaw = Float.pi / 2
        case .elevated:
            yaw = Float.pi / 4
            pitch = Float.pi / 4
            distance = 8
        }
    }

    mutating func reset() {
        self = OrbitCamera()
    }
}
