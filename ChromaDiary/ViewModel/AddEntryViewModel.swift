import SwiftUI
import SwiftData

@MainActor
class AddEntryViewModel: ObservableObject {
    @Published var entryText: String = ""
    @Published var selectedColor: Color = .gray
    @Published var entryDate: Date = .now
    
    private let hapticGenerator = UINotificationFeedbackGenerator()
    
    var isSaveButtonDisabled: Bool {
        false
    }
    
    init() {
        hapticGenerator.prepare()
    }
    
    func saveEntry(context: ModelContext) {
        let newEntry = DiaryEntry(date: entryDate, entryText: entryText, colorHex: selectedColor.toHex() ?? "#808080")
        context.insert(newEntry)
        
        do {
            try context.save()
            hapticGenerator.notificationOccurred(.success)
            NotificationManager.shared.scheduleDailyReminder()
        } catch {
            print("Failed to save entry: \(error.localizedDescription)")
            hapticGenerator.notificationOccurred(.error)
        }
    }
}
