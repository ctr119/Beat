import Foundation

struct TimerCountdownFormatStyle: FormatStyle {
    func format(_ value: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(value)) ?? ""
    }
}

extension FormatStyle where Self == TimerCountdownFormatStyle {
    static var timerCountdown: TimerCountdownFormatStyle { TimerCountdownFormatStyle() }
}
