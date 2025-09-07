

import SwiftUI

struct DiaryRowView: View {
    let entry: DiaryEntry
    
    @State private var isDarkBackground: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(entry.date, style: .time)
                    .fontWeight(.bold)
                
                Text(entry.entryText)
                    .font(.subheadline)
                    .opacity(0.8)
                    .lineLimit(2)
            }
            .foregroundColor(isDarkBackground ? .white : .black)
            
            Spacer()
        }
        .padding()
        .background(entry.color.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .onAppear {
            self.isDarkBackground = entry.color.isDark()
        }
    }
}
