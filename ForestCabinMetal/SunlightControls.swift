import Foundation
import SwiftUI

struct SunlightControls: View {
    @Binding var azimuthDegrees: Float
    @Binding var elevationDegrees: Float

    var body: some View {
        VStack(spacing: 8) {
            HStack{
                Text("Sun")

                Spacer()

                Button("Reset sun") {
                    azimuthDegrees = Sunlight.defaultAzimuthDegrees
                    elevationDegrees = Sunlight.defaultElevationDegrees
                }
            }

            HStack{
                Text("Azimuth")
                    .frame(width: 75, alignment: .leading)

                Slider(
                    value: $azimuthDegrees,
                    in: 0...360,
                    step: 1
                ) {
                    Text("Sun azimuth")
                }

                Text("\(Int(azimuthDegrees))")
                    .monospacedDigit()
                    .frame(width: 45, alignment: .trailing)
            }

            HStack{
                Text("Elevation")
                    .frame(width: 75, alignment: .leading)

                Slider(
                    value: $elevationDegrees,
                    in: 0...90,
                    step: 1
                ) {
                    Text("Sun elevation")
                }

                Text("\(Int(elevationDegrees))")
                    .monospacedDigit()
                    .frame(width: 45, alignment: .trailing)
            }
        }
    }
}
