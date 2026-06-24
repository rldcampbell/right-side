import SwiftData
import SwiftUI

enum AppTab {
    case draw
    case prompts
}

struct RootView: View {
    @Query(sort: \PromptCard.createdAt, order: .forward) private var prompts: [PromptCard]
    @State private var selectedTab = AppTab.draw

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                DrawView(selectedTab: $selectedTab)
            }
            .tabItem {
                Label("Draw", systemImage: "sparkles")
            }
            .tag(AppTab.draw)

            NavigationStack {
                PromptsView(openAddPromptOnAppear: prompts.isEmpty)
            }
            .tabItem {
                Label("Prompts", systemImage: "list.bullet")
            }
            .tag(AppTab.prompts)
        }
        .onAppear {
            if prompts.isEmpty {
                selectedTab = .prompts
            }
        }
        .onChange(of: prompts.isEmpty) { _, isEmpty in
            if isEmpty {
                selectedTab = .prompts
            }
        }
        .onChange(of: selectedTab) { _, tab in
            if tab == .draw, prompts.isEmpty {
                selectedTab = .prompts
            }
        }
    }
}
