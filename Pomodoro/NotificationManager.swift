import Foundation
import UserNotifications

/// Manages system notifications for the Pomodoro app
class NotificationManager {
    
    init() {
        requestPermission()
    }
    
    /// Request notification permissions from the user
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            }
        }
    }
    
    /// Send a notification when a session completes
    func sendSessionCompleteNotification(session: SessionType) {
        let content = UNMutableNotificationContent()
        
        switch session {
        case .work:
            content.title = "Work Session Complete! \(session.icon)"
            content.body = "Great job! Time for a break."
            content.sound = .default
        case .shortBreak:
            content.title = "Break's Over! \(session.icon)"
            content.body = "Ready to focus again?"
            content.sound = .default
        case .longBreak:
            content.title = "Long Break Complete! \(session.icon)"
            content.body = "Feeling refreshed? Let's get back to work!"
            content.sound = .default
        }
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil  // Deliver immediately
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to send notification: \(error.localizedDescription)")
            }
        }
    }
}
