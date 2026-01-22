import SwiftUI

@main
struct PomodoroApp: App {
    @State private var timerManager = TimerManager()
    
    var body: some Scene {
        MenuBarExtra {
            ContentView(timerManager: timerManager)
        } label: {
            Text(timerManager.menuBarTitle)
        }
        .menuBarExtraStyle(.window)
    }
}
