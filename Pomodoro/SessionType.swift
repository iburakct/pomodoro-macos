import Foundation

/// Represents the different types of Pomodoro sessions
enum SessionType: String, CaseIterable {
    case work = "Work Session"
    case shortBreak = "Short Break"
    case longBreak = "Long Break"
    
    /// Duration in seconds for each session type
    var duration: TimeInterval {
        switch self {
        case .work:
            return 25 * 60  // 25 minutes
        case .shortBreak:
            return 5 * 60   // 5 minutes
        case .longBreak:
            return 15 * 60  // 15 minutes
        }
    }
    
    /// Icon for each session type (used in UI and notifications)
    var icon: String {
        switch self {
        case .work:
            return "🍅"
        case .shortBreak:
            return "☕️"
        case .longBreak:
            return "🌴"
        }
    }
    
    /// Color name for each session type
    var colorName: String {
        switch self {
        case .work:
            return "tomato"
        case .shortBreak:
            return "mint"
        case .longBreak:
            return "ocean"
        }
    }
}
