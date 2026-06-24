import SwiftData
import SwiftUI

struct PromptsView: View {
    let openAddPromptOnAppear: Bool

    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PromptCard.createdAt, order: .forward) private var prompts: [PromptCard]
    @State private var showingAddPrompt = false
    @State private var didOpenInitialPrompt = false

    var body: some View {
        List {
            ForEach(prompts) { prompt in
                NavigationLink {
                    PromptEditorView(prompt: prompt)
                } label: {
                    PromptRow(prompt: prompt)
                }
            }
            .onDelete(perform: deletePrompts)
        }
        .overlay {
            if prompts.isEmpty {
                ContentUnavailableView {
                    Label("No prompts", systemImage: "plus.circle")
                } actions: {
                    Button("Add Prompt") {
                        showingAddPrompt = true
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .navigationTitle("Prompts")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddPrompt = true
                } label: {
                    Label("Add Prompt", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddPrompt) {
            NavigationStack {
                PromptEditorView(prompt: nil)
            }
        }
        .onAppear {
            guard openAddPromptOnAppear, prompts.isEmpty, !didOpenInitialPrompt else {
                return
            }

            didOpenInitialPrompt = true
            showingAddPrompt = true
        }
    }

    private func deletePrompts(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(prompts[index])
        }

        try? modelContext.save()
    }
}

private struct PromptRow: View {
    let prompt: PromptCard

    var body: some View {
        Text(prompt.text)
            .lineLimit(2)
            .font(.body)
            .padding(.vertical, 6)
    }
}
