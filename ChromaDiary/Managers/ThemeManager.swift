import SwiftUI


@MainActor
class ThemeManager: ObservableObject {
    
    @AppStorage("selectedThemeID") private var selectedThemeID: String = ThemeStore.defaultTheme.id
    
    
    @Published var currentTheme: Theme = ThemeStore.defaultTheme
    
    init() {
        
        loadTheme()
    }
    
    func changeTheme(to themeID: String) {
        
        if let newTheme = ThemeStore.themes.first(where: { $0.id == themeID }) {
            self.currentTheme = newTheme
            self.selectedThemeID = newTheme.id
            print("Theme changed to: \(newTheme.id)")
        }
    }
    
    private func loadTheme() {
        
        self.changeTheme(to: selectedThemeID)
    }
}
