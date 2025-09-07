

import SwiftUI
import SwiftData

struct MoodScapeView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var displayDate: Date
    
    @Query(sort: \DiaryEntry.date, order: .reverse) private var entries: [DiaryEntry]
    
    private var entriesByDate: [Date: DiaryEntry] {
        var dictionary: [Date: DiaryEntry] = [:]
        for entry in entries {
            let startOfDay = Calendar.current.startOfDay(for: entry.date)
            if dictionary[startOfDay] == nil {
                dictionary[startOfDay] = entry
            }
        }
        return dictionary
    }
    
    private var daysInMonth: [Date?] {
        guard let monthInterval = Calendar.current.dateInterval(of: .month, for: displayDate) else { return [] }
        
        let firstDayOfMonth = monthInterval.start
        let firstWeekday = Calendar.current.component(.weekday, from: firstDayOfMonth)
        
        var calendarDays: [Date?] = []
        let calendar = Calendar.current
        
        let startingDayOffset = (firstWeekday - calendar.firstWeekday + 7) % 7
        for _ in 0..<startingDayOffset {
            calendarDays.append(nil)
        }
        
        let daysInMonthCount = calendar.range(of: .day, in: .month, for: displayDate)!.count
        for dayOffset in 0..<daysInMonthCount {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: firstDayOfMonth) {
                calendarDays.append(date)
            }
        }
        
        return calendarDays
    }
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: { changeMonth(by: -1) }) {
                        Image(systemName: "chevron.left")
                    }
                    Spacer()
                    Text(displayDate.formatted(.dateTime.month(.wide).year()))
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Button(action: { changeMonth(by: 1) }) {
                        Image(systemName: "chevron.right")
                    }
                }
                .padding()

                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(Array(daysInMonth.enumerated()), id: \.offset) { index, date in
                        CalendarDayView(entry: date != nil ? entriesByDate[date!] : nil, date: date)
                            .onTapGesture {
                                if let date = date {
                                    self.displayDate = date
                                    dismiss()
                                }
                            }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("MoodScape")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func changeMonth(by amount: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: amount, to: displayDate) {
            withAnimation {
                displayDate = newDate
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var date = Date.now
        
        var body: some View {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try! ModelContainer(for: DiaryEntry.self, configurations: config)
            
            let sampleEntries = [
                DiaryEntry(date: .now, entryText: "Preview entry", colorHex: "#FF9500")
            ]
            sampleEntries.forEach { container.mainContext.insert($0) }
            
            return MoodScapeView(displayDate: $date)
                .modelContainer(container)
                .environmentObject(ThemeManager())
        }
    }
    return PreviewWrapper()
}
