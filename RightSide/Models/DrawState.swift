import Foundation
import SwiftData

@Model
final class DrawState {
    static let defaultKey = "default"

    @Attribute(.unique) var key: String
    var lastPromptID: UUID?

    init(key: String = DrawState.defaultKey, lastPromptID: UUID? = nil) {
        self.key = key
        self.lastPromptID = lastPromptID
    }
}
