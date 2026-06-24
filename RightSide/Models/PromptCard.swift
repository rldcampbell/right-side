import Foundation
import SwiftData

@Model
final class PromptCard {
    @Attribute(.unique) var id: UUID
    var text: String
    var createdAt: Date
    var updatedAt: Date
    var lastShownAt: Date?
    var shownCount: Int
    var themeIndex: Int

    init(
        id: UUID = UUID(),
        text: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        lastShownAt: Date? = nil,
        shownCount: Int = 0,
        themeIndex: Int? = nil
    ) {
        self.id = id
        self.text = text
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.lastShownAt = lastShownAt
        self.shownCount = shownCount
        self.themeIndex = themeIndex ?? CardTheme.index(for: id)
    }
}
