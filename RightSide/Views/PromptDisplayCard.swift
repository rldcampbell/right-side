import SwiftUI

struct PromptDisplayCard: View {
    @Environment(\.colorScheme) private var colorScheme
    let prompt: PromptCard

    private var theme: CardTheme {
        CardTheme.theme(for: prompt.themeIndex)
    }

    var body: some View {
        let palette = theme.palette(for: colorScheme)

        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(palette.background)

            CardCircles(promptID: prompt.id, palette: palette)

            Text(prompt.text)
                .font(.system(.title2, design: .serif))
                .fontWeight(.regular)
                .lineSpacing(6)
                .multilineTextAlignment(.center)
                .foregroundStyle(palette.text)
                .padding(36)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(palette.stroke, lineWidth: 1)
        }
        .shadow(color: .black.opacity(colorScheme == .dark ? 0.35 : 0.12), radius: 20, y: 10)
        .frame(maxWidth: 430)
        .aspectRatio(0.76, contentMode: .fit)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(prompt.text)
    }
}

private struct CardCircles: View {
    let promptID: UUID
    let palette: CardTheme.Palette

    var body: some View {
        GeometryReader { proxy in
            let circles = Self.makeCircles(promptID: promptID)
            let shortSide = min(proxy.size.width, proxy.size.height)

            ZStack {
                ForEach(circles) { circle in
                    Circle()
                        .fill(palette.circles[circle.colorIndex % palette.circles.count])
                        .opacity(circle.opacity)
                        .frame(width: shortSide * circle.scale, height: shortSide * circle.scale)
                        .position(
                            x: proxy.size.width * circle.x,
                            y: proxy.size.height * circle.y
                        )
                        .blendMode(.plusLighter)
                }
            }
        }
        .allowsHitTesting(false)
    }

    private static func makeCircles(promptID: UUID) -> [DecorativeCircle] {
        var generator = SeededRandomGenerator(seed: promptID)
        let anchors: [(x: Double, y: Double)] = [
            (-0.04, 0.12),
            (0.96, 0.08),
            (1.05, 0.72),
            (0.16, 1.03),
            (-0.08, 0.78)
        ]

        return anchors.enumerated().map { index, anchor in
            DecorativeCircle(
                id: index,
                x: anchor.x + Double.random(in: -0.07...0.07, using: &generator),
                y: anchor.y + Double.random(in: -0.07...0.07, using: &generator),
                scale: Double.random(in: 0.34...0.56, using: &generator),
                opacity: Double.random(in: 0.24...0.42, using: &generator),
                colorIndex: Int.random(in: 0..<3, using: &generator)
            )
        }
    }
}

private struct DecorativeCircle: Identifiable {
    let id: Int
    let x: Double
    let y: Double
    let scale: Double
    let opacity: Double
    let colorIndex: Int
}
