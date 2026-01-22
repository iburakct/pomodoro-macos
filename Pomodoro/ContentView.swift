import SwiftUI

struct ContentView: View {
    @Bindable var timerManager: TimerManager
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Text("\(timerManager.currentSession.icon) Pomodoro")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                // Reset all button
                Button {
                    timerManager.resetAll()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
                .help("Reset all")
            }
            
            Divider()
            
            // Timer Display
            VStack(spacing: 8) {
                // Progress Ring
                ZStack {
                    Circle()
                        .stroke(lineWidth: 8)
                        .opacity(0.1)
                        .foregroundStyle(sessionColor)
                    
                    Circle()
                        .trim(from: 0.0, to: timerManager.progress)
                        .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .foregroundStyle(sessionColor)
                        .rotationEffect(.degrees(-90))
                        .animation(.linear(duration: 1), value: timerManager.progress)
                    
                    VStack(spacing: 4) {
                        Text(timerManager.formattedTime)
                            .font(.system(size: 42, weight: .medium, design: .monospaced))
                        
                        Text(timerManager.currentSession.rawValue)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(width: 160, height: 160)
            }
            
            // Control Buttons
            HStack(spacing: 16) {
                // Reset button
                Button {
                    timerManager.reset()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.title2)
                        .frame(width: 44, height: 44)
                }
                .buttonStyle(.plain)
                .background(.quaternary, in: Circle())
                .help("Reset timer")
                
                // Play/Pause button
                Button {
                    timerManager.toggle()
                } label: {
                    Image(systemName: timerManager.isRunning ? "pause.fill" : "play.fill")
                        .font(.title)
                        .frame(width: 56, height: 56)
                        .foregroundStyle(.white)
                }
                .buttonStyle(.plain)
                .background(sessionColor, in: Circle())
                .help(timerManager.isRunning ? "Pause" : "Start")
                
                // Skip button
                Button {
                    timerManager.skip()
                } label: {
                    Image(systemName: "forward.fill")
                        .font(.title2)
                        .frame(width: 44, height: 44)
                }
                .buttonStyle(.plain)
                .background(.quaternary, in: Circle())
                .help("Skip to next session")
            }
            
            Divider()
            
            // Session Counter
            HStack {
                Text("Completed:")
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 4) {
                    ForEach(0..<4, id: \.self) { index in
                        let cycleCount = timerManager.completedPomodoros % 4
                        let isFilled = index < cycleCount || (cycleCount == 0 && timerManager.completedPomodoros > 0 && index < 4)
                        Text(isFilled && !(cycleCount == 0 && timerManager.completedPomodoros == 0) ? "🍅" : "○")
                            .font(.system(size: 14))
                    }
                }
                
                Spacer()
                
                Text("\(timerManager.completedPomodoros) total")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
            
            // Quit button
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .buttonStyle(.plain)
            .foregroundStyle(.secondary)
            .font(.caption)
        }
        .padding(20)
        .frame(width: 240)
    }
    
    private var sessionColor: Color {
        switch timerManager.currentSession {
        case .work:
            return .red
        case .shortBreak:
            return .green
        case .longBreak:
            return .blue
        }
    }
}

#Preview {
    ContentView(timerManager: TimerManager())
}
