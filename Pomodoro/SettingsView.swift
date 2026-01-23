import SwiftUI

struct SettingsView: View {
    @Bindable var settings: SettingsManager
    var onDurationChange: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                Text("⚙️ Settings")
                    .font(.headline)
                Spacer()
            }
            
            Divider()
            
            // Duration Settings
            VStack(spacing: 12) {
                DurationRow(
                    icon: "🍅",
                    label: "Work",
                    value: $settings.workDuration,
                    range: 1...60,
                    onChange: onDurationChange
                )
                
                DurationRow(
                    icon: "☕️",
                    label: "Short Break",
                    value: $settings.shortBreakDuration,
                    range: 1...30,
                    onChange: onDurationChange
                )
                
                DurationRow(
                    icon: "🌴",
                    label: "Long Break",
                    value: $settings.longBreakDuration,
                    range: 1...30,
                    onChange: onDurationChange
                )
            }
            
            Divider()
            
            // Reset Button
            Button {
                settings.resetToDefaults()
                onDurationChange()
            } label: {
                Text("Reset to Defaults")
                    .font(.caption)
            }
            .buttonStyle(.plain)
            .foregroundStyle(.secondary)
        }
        .padding(16)
        .frame(width: 220)
    }
}

struct DurationRow: View {
    let icon: String
    let label: String
    @Binding var value: Int
    let range: ClosedRange<Int>
    var onChange: () -> Void
    
    var body: some View {
        HStack {
            Text(icon)
            Text(label)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            HStack(spacing: 8) {
                Button {
                    if value > range.lowerBound {
                        value -= 1
                        onChange()
                    }
                } label: {
                    Image(systemName: "minus.circle")
                }
                .buttonStyle(.plain)
                .disabled(value <= range.lowerBound)
                
                Text("\(value) min")
                    .font(.system(.body, design: .monospaced))
                    .frame(minWidth: 50)
                
                Button {
                    if value < range.upperBound {
                        value += 1
                        onChange()
                    }
                } label: {
                    Image(systemName: "plus.circle")
                }
                .buttonStyle(.plain)
                .disabled(value >= range.upperBound)
            }
        }
    }
}

#Preview {
    SettingsView(settings: SettingsManager(), onDurationChange: {})
}
