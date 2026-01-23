import SwiftUI
import Combine

@main
struct PomodoroApp: App {
    @State private var timerManager = TimerManager()
    @State private var overlayWindow = CountdownOverlayWindow()
    @State private var cancellable: AnyCancellable?
    
    var body: some Scene {
        MenuBarExtra {
            ContentView(timerManager: timerManager)
                .onAppear {
                    setupOverlayObserver()
                }
        } label: {
            Text(timerManager.menuBarTitle)
        }
        .menuBarExtraStyle(.window)
    }
    
    private func setupOverlayObserver() {
        // Use a timer to check for countdown state changes
        cancellable = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                updateOverlay()
            }
    }
    
    private func updateOverlay() {
        if timerManager.showCountdownOverlay {
            overlayWindow.show(number: timerManager.countdownNumber)
        } else {
            if overlayWindow.isVisible {
                overlayWindow.hide()
            }
        }
    }
}
