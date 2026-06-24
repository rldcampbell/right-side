import SwiftData
import SwiftUI

struct PromptEditorView: View {
    let prompt: PromptCard?

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var text: String

    init(prompt: PromptCard?) {
        self.prompt = prompt
        _text = State(initialValue: prompt?.text ?? "")
    }

    private var trimmedText: String {
        text.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var remainingCharacters: Int {
        PromptRules.maxLength - text.count
    }

    private var canSave: Bool {
        !trimmedText.isEmpty && text.count <= PromptRules.maxLength
    }

    var body: some View {
        Form {
            Section {
                TextEditor(text: $text)
                    .frame(minHeight: 150)
                    .onChange(of: text) { _, newValue in
                        guard newValue.count > PromptRules.maxLength else {
                            return
                        }

                        text = String(newValue.prefix(PromptRules.maxLength))
                    }

                HStack {
                    Spacer()

                    Text("\(remainingCharacters) characters")
                        .font(.footnote)
                        .foregroundStyle(remainingCharacters < 0 ? .red : .secondary)
                }
            }
        }
        .navigationTitle(prompt == nil ? "New Prompt" : "Edit Prompt")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    savePrompt()
                }
                .disabled(!canSave)
            }
        }
    }

    private func savePrompt() {
        let now = Date()

        if let prompt {
            prompt.text = trimmedText
            prompt.updatedAt = now
        } else {
            let prompt = PromptCard(text: trimmedText, createdAt: now, updatedAt: now)
            modelContext.insert(prompt)
        }

        try? modelContext.save()
        dismiss()
    }
}
