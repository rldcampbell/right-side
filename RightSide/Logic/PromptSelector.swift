import Foundation

enum PromptSelector {
    static func choose(
        from prompts: [PromptCard],
        randomIndex: (Int) -> Int = { Int.random(in: 0..<$0) }
    ) -> PromptCard? {
        guard !prompts.isEmpty else {
            return nil
        }

        let excludedCount = Int(Double(prompts.count) * PromptRules.recencyExclusionFraction)
        let recentlyShownIDs = Set(
            prompts
                .compactMap { prompt -> (id: UUID, shownAt: Date)? in
                    guard let shownAt = prompt.lastShownAt else {
                        return nil
                    }

                    return (prompt.id, shownAt)
                }
                .sorted { $0.shownAt > $1.shownAt }
                .prefix(excludedCount)
                .map(\.id)
        )

        let eligiblePrompts = prompts.filter { !recentlyShownIDs.contains($0.id) }
        let pool = eligiblePrompts.isEmpty ? prompts : eligiblePrompts
        let index = clamped(randomIndex(pool.count), lowerBound: 0, upperBound: pool.count - 1)

        return pool[index]
    }

    private static func clamped(_ value: Int, lowerBound: Int, upperBound: Int) -> Int {
        min(max(value, lowerBound), upperBound)
    }
}
