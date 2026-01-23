import SwiftUI
import Combine

@main
struct PomodoroApp: App {
    @State private var settingsManager = SettingsManager()
    @State private var timerManager: TimerManager
    @State private var overlayWindow = CountdownOverlayWindow()
    @State private var cancellable: AnyCancellable?
    
    init() {
        let settings = SettingsManager()
        _settingsManager = State(initialValue: settings)
        _timerManager = State(initialValue: TimerManager(settings: settings))
    }
    
    var body: some Scene {
        MenuBarExtra {
            ContentView(timerManager: timerManager, settings: settingsManager)
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
