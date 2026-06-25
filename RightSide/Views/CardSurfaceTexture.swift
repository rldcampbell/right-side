import SwiftUI

struct CardSurfaceTexture: View {
    let seed: UUID
    let colorScheme: ColorScheme

    var body: some View {
        GeometryReader { proxy in
            let marks = Self.makeMarks(seed: seed)

            ZStack {
                LinearGradient(
                    colors: highlightColors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .opacity(colorScheme == .dark ? 0.18 : 0.28)

                ForEach(marks) { mark in
                    Capsule(style: .continuous)
                        .fill(markColor.opacity(mark.opacity))
                        .frame(width: mark.length, height: mark.thickness)
                        .rotationEffect(.degrees(mark.rotation))
                        .position(
                            x: proxy.size.width * mark.x,
                            y: proxy.size.height * mark.y
                        )
                }
            }
        }
        .blendMode(colorScheme == .dark ? .screen : .multiply)
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }

    private var highlightColors: [Color] {
        colorScheme == .dark
            ? [.white.opacity(0.06), .clear, .black.opacity(0.12)]
            : [.white.opacity(0.45), .clear, .black.opacity(0.05)]
    }

    private var markColor: Color {
        colorScheme == .dark ? .white : .black
    }

    private static func makeMarks(seed: UUID) -> [TextureMark] {
        var generator = SeededRandomGenerator(seed: seed)

        return (0..<42).map { index in
            TextureMark(
                id: index,
                x: Double.random(in: 0.03...0.97, using: &generator),
                y: Double.random(in: 0.03...0.97, using: &generator),
                length: Double.random(in: 3...13, using: &generator),
                thickness: Double.random(in: 0.45...1.1, using: &generator),
                rotation: Double.random(in: -24...24, using: &generator),
                opacity: Double.random(in: 0.018...0.055, using: &generator)
            )
        }
    }
}

private struct TextureMark: Identifiable {
    let id: Int
    let x: Double
    let y: Double
    let length: Double
    let thickness: Double
    let rotation: Double
    let opacity: Double
}
