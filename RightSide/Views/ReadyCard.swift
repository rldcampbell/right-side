import SwiftUI

struct ReadyCard: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(background)

            Text("Ready when you are.")
                .font(.system(.title2, design: .serif))
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(36)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(.quaternary, lineWidth: 1)
        }
        .frame(maxWidth: 430)
        .aspectRatio(0.76, contentMode: .fit)
    }

    private var background: Color {
        colorScheme == .dark
            ? Color(red: 0.16, green: 0.16, blue: 0.17)
            : Color(red: 0.95, green: 0.94, blue: 0.92)
    }
}
