import SwiftUI

struct AddEntryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @StateObject private var viewModel = AddEntryViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                DatePicker(
                    "Date",
                    selection: $viewModel.entryDate,
                    displayedComponents: .date
                )
                .padding(.horizontal)
                
                ColorPicker("Select your mood color", selection: $viewModel.selectedColor, supportsOpacity: false)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))

                TextField("Add an optional note...", text: $viewModel.entryText, axis: .vertical)
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(10)
                    .lineLimit(3...6)
                
                Spacer()
            }
            .padding()
            .navigationTitle("New Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.saveEntry(context: modelContext)
                        dismiss()
                    }
                }
            }
        }
    }
}
