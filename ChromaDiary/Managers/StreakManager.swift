
import Foundation
import SwiftData

@MainActor
class StreakManager: ObservableObject {
    @Published var currentStreak: Int = 0
    
    func updateStreak(with entries: [DiaryEntry]) {
        guard !entries.isEmpty else {
            currentStreak = 0
            return
        }
        
        var streak = 0
        var currentDate = Calendar.current.startOfDay(for: .now)
        let uniqueDays = Set(entries.map { Calendar.current.startOfDay(for: $0.date) })
        
        if uniqueDays.contains(currentDate) {
            streak += 1
            while let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) {
                if uniqueDays.contains(previousDay) {
                    streak += 1
                    currentDate = previousDay
                } else {
                    break
                }
            }
        }
        
        self.currentStreak = streak
    }
}
