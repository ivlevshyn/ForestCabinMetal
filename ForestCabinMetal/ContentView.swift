import SwiftUI

struct ContentView: View {
    @State private var animationPaused = false
    @State private var resetID = 0
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(animationPaused ? "Resume" : "Pause"){
                    animationPaused.toggle()
                }
                
                Button("Reset") {
                    resetID += 1
                }
                
                Spacer()
                
                Text(animationPaused ? "Paused" : "Animating")
            }.padding()
            
            MetalView(
                animationPaused: animationPaused,
                resetID: resetID,
                sceneActive: scenePhase == .active).frame(maxWidth: 320, maxHeight: 240)
            
        }
        
        
    }
}

#Preview {
    ContentView()
}
