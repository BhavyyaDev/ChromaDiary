
import SwiftUI
import SwiftData

@Model
final class DiaryEntry {
    var id: UUID
    var date: Date
    var entryText: String
    var colorHex: String
    
    init(date: Date, entryText: String, colorHex: String) {
        self.id = UUID()
        self.date = date
        self.entryText = entryText
        self.colorHex = colorHex
    }
    
    var color: Color {
        Color(self.colorHex)
    }
}
