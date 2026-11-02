import SwiftUI

struct ContentView: View {
    @State private var animationPaused = false
    @State private var resetID = 0
    @State private var cameraPreset: OrbitCamera.Preset = .baseline
    @State private var cameraRequestID = 0

    @State private var sunAzimuthDegrees = Sunlight.defaultAzimuthDegrees
    @State private var sunElevationDegrees = Sunlight.defaultElevationDegrees
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(animationPaused ? "Resume" : "Pause"){
                    animationPaused.toggle()
                }
                
                Button("Reset animation") {
                    resetID += 1
                }

                Button("Reset camera") {
                    cameraPreset = .baseline
                    cameraRequestID += 1
                }

                Menu("Camera views") {
                    ForEach(OrbitCamera.Preset.allCases, id: \.self) {
                        preset in
                        Button(preset.rawValue) {
                            cameraPreset = preset
                            cameraRequestID += 1
                        }
                    }
                }

                Spacer()
                
                Text(animationPaused ? "Paused" : "Animating")
            }.padding()

            SunlightControls(
                azimuthDegrees: $sunAzimuthDegrees,
                elevationDegrees: $sunElevationDegrees
            )
            .padding(.horizontal)
            .padding(.bottom)

            MetalView(
                animationPaused: animationPaused,
                resetID: resetID,
                sceneActive: scenePhase == .active,
                cameraPreset: cameraPreset,
                cameraRequestID: cameraRequestID,
                sunAzimuthDegrees: sunAzimuthDegrees,
                sunElevationDegrees: sunElevationDegrees
            ).frame(minWidth: 320, minHeight: 240)

        }
        
        
    }
}

#Preview {
    ContentView()
}
