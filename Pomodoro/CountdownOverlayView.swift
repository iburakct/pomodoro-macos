import SwiftUI

/// View for the fullscreen countdown overlay (3, 2, 1)
struct CountdownOverlayView: View {
    let number: Int
    
    var body: some View {
        ZStack {
            // Semi-transparent black background
            Color.black.opacity(0.3)
            
            // Large countdown number
            Text("\(number)")
                .font(.system(size: 300, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                .contentTransition(.numericText())
                .animation(.easeInOut(duration: 0.3), value: number)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CountdownOverlayView(number: 3)
}
