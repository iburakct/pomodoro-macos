import SwiftUI

/// View for the fullscreen countdown overlay (5, 4, 3, 2, 1)
struct CountdownOverlayView: View {
    let number: Int
    
    var body: some View {
        ZStack {
            // No background - fully transparent
            Color.clear
            
            // Barely visible white number
            Text("\(number)")
                .font(.system(size: 400, weight: .bold, design: .rounded))
                .foregroundStyle(.white.opacity(0.25))
                .contentTransition(.numericText())
                .animation(.easeInOut(duration: 0.3), value: number)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CountdownOverlayView(number: 5)
        .background(.black)
}
