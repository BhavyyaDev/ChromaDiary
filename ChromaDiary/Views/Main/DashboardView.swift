
import SwiftUI
import SwiftData

struct DashboardView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Query(sort: \DiaryEntry.date, order: .reverse) private var allEntries: [DiaryEntry]
    
    @StateObject private var streakManager = StreakManager()
    @State private var selectedDate: Date = .now
    
    @State private var isShowingAddSheet = false
    @State private var isShowingCalendarSheet = false
    
    private let selectionFeedback = UISelectionFeedbackGenerator()
    
    private var headerTitle: String {
        if Calendar.current.isDateInToday(selectedDate) {
            return "Today's Entries"
        } else {
            return selectedDate.formatted(date: .abbreviated, time: .omitted)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Text(headerTitle)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        isShowingCalendarSheet = true
                    } label: {
                        Image(systemName: "calendar")
                            .font(.title3)
                    }
                }
                .padding()
                
                
                if streakManager.currentStreak > 0 {
                    let streakText = streakManager.currentStreak == 1 ? "1 Day Streak! 🎉" : "\(streakManager.currentStreak) Day Streak! 🔥"
                    Text(streakText)
                        .font(.headline)
                        .foregroundColor(themeManager.currentTheme.accentColor)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)
                        .transition(.scale.combined(with: .opacity))
                }
                
                DailyEntriesListView(day: selectedDate)
            }
            .background(themeManager.currentTheme.backgroundColor)
            .navigationTitle("HuesOfMe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { isShowingAddSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .tint(themeManager.currentTheme.accentColor)
            .sheet(isPresented: $isShowingAddSheet) {
                AddEntryView().environmentObject(themeManager)
            }
            .sheet(isPresented: $isShowingCalendarSheet) {
                MoodScapeView(displayDate: $selectedDate)
                    .environmentObject(themeManager)
            }
            .onAppear(perform: setupInitialActions)
            .onChange(of: allEntries) {
                withAnimation {
                    streakManager.updateStreak(with: allEntries)
                }
            }
            .onChange(of: selectedDate) {
                selectionFeedback.selectionChanged()
            }
        }
    }
    
    private func setupInitialActions() {
        selectionFeedback.prepare()
        NotificationManager.shared.requestPermission()
        streakManager.updateStreak(with: allEntries)
    }
}
struct DailyEntriesListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query var entries: [DiaryEntry]
    
    init(day: Date) {
        let start = Calendar.current.startOfDay(for: day)
        let end = Calendar.current.date(byAdding: .day, value: 1, to: start)!
        let predicate = #Predicate<DiaryEntry> { $0.date >= start && $0.date < end }
        _entries = Query(filter: predicate, sort: \.date, order: .reverse)
    }
    
    var body: some View {
        if entries.isEmpty {
            ContentUnavailableView("No Entries",
                                   systemImage: "square.stack.3d.up.slash",
                                   description: Text("No entries were logged on this day."))
        } else {
            List {
                ForEach(entries) { entry in
                    DiaryRowView(entry: entry)
                }
                .onDelete(perform: deleteEntry)
            }
            .listStyle(.plain)
        }
    }
    
    private func deleteEntry(at offsets: IndexSet) {
        for offset in offsets {
            let entry = entries[offset]
            modelContext.delete(entry)
        }
    }
}
