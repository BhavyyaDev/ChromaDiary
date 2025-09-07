
import SwiftUI

struct Theme: Identifiable, Codable {
    let id: String
    let accentColor: Color
    let secondaryColor: Color
    let backgroundColor: Color
    
    
    
    enum CodingKeys: String, CodingKey {
        case id, accentColor, secondaryColor, backgroundColor
    }
    
    
    func encode(to encoder: Encoder) throws {
        
    }
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        
        
        accentColor = .black
        secondaryColor = .gray
        backgroundColor = .white
    }
    
    
    init(id: String, accent: Color, secondary: Color, background: Color) {
        self.id = id
        self.accentColor = accent
        self.secondaryColor = secondary
        self.backgroundColor = background
    }
}



class ThemeStore {
    static let themes: [Theme] = [
        Theme(id: "Default", accent: .blue, secondary: .gray, background: Color(uiColor: .systemGroupedBackground)),
        Theme(id: "Sunset", accent: .orange, secondary: .red, background: Color(red: 0.1, green: 0.1, blue: 0.2)),
        Theme(id: "Ocean", accent: .teal, secondary: .cyan, background: Color(red: 0.95, green: 0.98, blue: 1.0))
    ]
    
    static var defaultTheme: Theme {
        themes[0]
    }
}
