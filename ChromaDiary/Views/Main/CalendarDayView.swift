
import SwiftUI

struct CalendarDayView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    let entry: DiaryEntry?
    let date: Date?
    
    var body: some View {
        VStack {
            if let date = date {
                Text(date.formatted(.dateTime.day()))
                    .fontWeight(.bold)
                    
                    .foregroundColor(isDayInToday(date: date) ? .white : .primary)
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(
                        ZStack {
                            if isDayInToday(date: date) {
                                Circle()
                                    .fill(themeManager.currentTheme.accentColor)
                            }
                        }
                    )
            }
        }
        .frame(height: 50)
        .background(.clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private func isDayInToday(date: Date) -> Bool {
        Calendar.current.isDateInToday(date)
    }
}
