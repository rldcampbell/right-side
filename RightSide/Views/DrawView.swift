import SwiftData
import SwiftUI

struct DrawView: View {
    @Binding var selectedTab: AppTab
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PromptCard.createdAt, order: .forward) private var prompts: [PromptCard]
    @Query private var drawStates: [DrawState]

    private var lastDrawnPrompt: PromptCard? {
        guard let lastPromptID = drawState?.lastPromptID else {
            return nil
        }

        return prompts.first { $0.id == lastPromptID }
    }

    private var drawState: DrawState? {
        drawStates.first { $0.key == DrawState.defaultKey }
    }

    var body: some View {
        VStack(spacing: 28) {
            if prompts.isEmpty {
                ContentUnavailableView {
                    Label("Add a prompt", systemImage: "plus.circle")
                } description: {
                    Text("Create one prompt before drawing a card.")
                } actions: {
                    Button("Add Prompt") {
                        selectedTab = .prompts
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                Spacer(minLength: 16)

                if let lastDrawnPrompt {
                    PromptDisplayCard(prompt: lastDrawnPrompt)
                        .transition(.opacity.combined(with: .scale(scale: 0.98)))
                } else {
                    ReadyCard()
                }

                Spacer(minLength: 16)

                Button {
                    drawCard()
                } label: {
                    Text("Draw a card")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.bottom, 12)
            }
        }
        .animation(.snappy, value: lastDrawnPrompt?.id)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, 20)
        .padding(.top, 12)
    }

    private func drawCard() {
        guard let prompt = PromptSelector.choose(from: prompts) else {
            return
        }

        let now = Date()
        prompt.lastShownAt = now
        prompt.shownCount += 1

        let state = drawState ?? makeDrawState()
        state.lastPromptID = prompt.id

        try? modelContext.save()
    }

    private func makeDrawState() -> DrawState {
        let state = DrawState()
        modelContext.insert(state)

        return state
    }
}
