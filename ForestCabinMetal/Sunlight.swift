import Foundation
import simd

struct Sunlight {
    static let defaultAzimuthDegrees: Float = 55
    static let defaultElevationDegrees: Float = 55

    var azimuthDegrees: Float = defaultAzimuthDegrees
    var elevationDegres: Float = defaultElevationDegrees

    var color = SIMD3<Float>(1.0, 0.95, 0.85)
    var intensity: Float = 0.75

    var ambientFill: Float = 0.15

    var unitDirectionToSun: SIMD3<Float> {
        precondition(
            azimuthDegrees.isFinite
            && elevationDegres.isFinite
            && elevationDegres >= 0
            && elevationDegres <= 90,
            "Sun angles must be finite, with elevation from 0 to 90 degrees."
        )

        let azimuth = azimuthDegrees * .pi / 180
        let elevation = elevationDegres * .pi / 180

        let horizontalLength = cos(elevation)

        let direction = SIMD3<Float>(
            horizontalLength * sin(azimuth),
            sin(elevation),
            horizontalLength * cos(azimuth)
        )

        return simd_normalize(direction)
    }
}
