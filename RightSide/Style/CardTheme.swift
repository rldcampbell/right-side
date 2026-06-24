import Foundation
import SwiftUI

enum CardTheme: Int, CaseIterable {
    case roseGarden
    case blueHour
    case meadow
    case lantern
    case lilac
    case tide

    struct Palette {
        let background: Color
        let circles: [Color]
        let text: Color
        let stroke: Color
    }

    static func index(for id: UUID) -> Int {
        let count = allCases.count
        let uuid = id.uuid

        return withUnsafeBytes(of: uuid) { bytes in
            bytes.reduce(0) { partial, byte in
                (partial * 31 + Int(byte)) % count
            }
        }
    }

    static func theme(for index: Int) -> CardTheme {
        let themes = allCases
        let normalizedIndex = ((index % themes.count) + themes.count) % themes.count

        return themes[normalizedIndex]
    }

    func palette(for colorScheme: ColorScheme) -> Palette {
        switch (self, colorScheme) {
        case (.roseGarden, .dark):
            return Palette(
                background: Color(red: 0.18, green: 0.14, blue: 0.16),
                circles: [
                    Color(red: 0.86, green: 0.38, blue: 0.48),
                    Color(red: 0.95, green: 0.62, blue: 0.42),
                    Color(red: 0.55, green: 0.72, blue: 0.63)
                ],
                text: Color(red: 0.97, green: 0.92, blue: 0.89),
                stroke: Color.white.opacity(0.10)
            )
        case (.roseGarden, _):
            return Palette(
                background: Color(red: 0.97, green: 0.92, blue: 0.90),
                circles: [
                    Color(red: 0.84, green: 0.29, blue: 0.40),
                    Color(red: 0.96, green: 0.58, blue: 0.36),
                    Color(red: 0.44, green: 0.67, blue: 0.55)
                ],
                text: Color(red: 0.18, green: 0.13, blue: 0.13),
                stroke: Color.black.opacity(0.08)
            )
        case (.blueHour, .dark):
            return Palette(
                background: Color(red: 0.12, green: 0.15, blue: 0.20),
                circles: [
                    Color(red: 0.36, green: 0.66, blue: 0.91),
                    Color(red: 0.63, green: 0.55, blue: 0.88),
                    Color(red: 0.92, green: 0.74, blue: 0.42)
                ],
                text: Color(red: 0.91, green: 0.94, blue: 0.96),
                stroke: Color.white.opacity(0.10)
            )
        case (.blueHour, _):
            return Palette(
                background: Color(red: 0.91, green: 0.94, blue: 0.96),
                circles: [
                    Color(red: 0.24, green: 0.52, blue: 0.82),
                    Color(red: 0.57, green: 0.47, blue: 0.79),
                    Color(red: 0.90, green: 0.62, blue: 0.28)
                ],
                text: Color(red: 0.10, green: 0.14, blue: 0.19),
                stroke: Color.black.opacity(0.08)
            )
        case (.meadow, .dark):
            return Palette(
                background: Color(red: 0.13, green: 0.18, blue: 0.15),
                circles: [
                    Color(red: 0.42, green: 0.76, blue: 0.52),
                    Color(red: 0.88, green: 0.79, blue: 0.38),
                    Color(red: 0.38, green: 0.68, blue: 0.78)
                ],
                text: Color(red: 0.91, green: 0.95, blue: 0.91),
                stroke: Color.white.opacity(0.10)
            )
        case (.meadow, _):
            return Palette(
                background: Color(red: 0.91, green: 0.95, blue: 0.89),
                circles: [
                    Color(red: 0.30, green: 0.62, blue: 0.38),
                    Color(red: 0.86, green: 0.70, blue: 0.24),
                    Color(red: 0.22, green: 0.55, blue: 0.66)
                ],
                text: Color(red: 0.11, green: 0.17, blue: 0.12),
                stroke: Color.black.opacity(0.08)
            )
        case (.lantern, .dark):
            return Palette(
                background: Color(red: 0.20, green: 0.16, blue: 0.12),
                circles: [
                    Color(red: 0.96, green: 0.61, blue: 0.26),
                    Color(red: 0.87, green: 0.35, blue: 0.31),
                    Color(red: 0.47, green: 0.72, blue: 0.74)
                ],
                text: Color(red: 0.98, green: 0.92, blue: 0.84),
                stroke: Color.white.opacity(0.10)
            )
        case (.lantern, _):
            return Palette(
                background: Color(red: 0.97, green: 0.92, blue: 0.84),
                circles: [
                    Color(red: 0.93, green: 0.49, blue: 0.16),
                    Color(red: 0.80, green: 0.25, blue: 0.22),
                    Color(red: 0.25, green: 0.58, blue: 0.62)
                ],
                text: Color(red: 0.20, green: 0.14, blue: 0.09),
                stroke: Color.black.opacity(0.08)
            )
        case (.lilac, .dark):
            return Palette(
                background: Color(red: 0.16, green: 0.14, blue: 0.20),
                circles: [
                    Color(red: 0.70, green: 0.52, blue: 0.88),
                    Color(red: 0.45, green: 0.70, blue: 0.86),
                    Color(red: 0.91, green: 0.58, blue: 0.67)
                ],
                text: Color(red: 0.94, green: 0.91, blue: 0.97),
                stroke: Color.white.opacity(0.10)
            )
        case (.lilac, _):
            return Palette(
                background: Color(red: 0.94, green: 0.91, blue: 0.97),
                circles: [
                    Color(red: 0.55, green: 0.36, blue: 0.76),
                    Color(red: 0.32, green: 0.59, blue: 0.77),
                    Color(red: 0.86, green: 0.42, blue: 0.55)
                ],
                text: Color(red: 0.15, green: 0.12, blue: 0.20),
                stroke: Color.black.opacity(0.08)
            )
        case (.tide, .dark):
            return Palette(
                background: Color(red: 0.10, green: 0.17, blue: 0.18),
                circles: [
                    Color(red: 0.29, green: 0.74, blue: 0.78),
                    Color(red: 0.35, green: 0.58, blue: 0.88),
                    Color(red: 0.88, green: 0.71, blue: 0.44)
                ],
                text: Color(red: 0.89, green: 0.96, blue: 0.96),
                stroke: Color.white.opacity(0.10)
            )
        case (.tide, _):
            return Palette(
                background: Color(red: 0.89, green: 0.96, blue: 0.95),
                circles: [
                    Color(red: 0.16, green: 0.59, blue: 0.64),
                    Color(red: 0.23, green: 0.45, blue: 0.78),
                    Color(red: 0.84, green: 0.57, blue: 0.27)
                ],
                text: Color(red: 0.08, green: 0.17, blue: 0.18),
                stroke: Color.black.opacity(0.08)
            )
        }
    }
}
