import SwiftData
import SwiftUI

@main
struct RightSideApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [PromptCard.self, DrawState.self])
    }
}
