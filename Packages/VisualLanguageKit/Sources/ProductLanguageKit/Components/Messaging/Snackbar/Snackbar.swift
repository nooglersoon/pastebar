import SwiftUI

public struct Snackbar: View {
    public var title: String
    public var style: Style
    public var image: Image {
        switch style {
        case .error: return Image(systemName: "xmark.circle.fill")
        case .success: return Image(systemName: "checkmark.circle.fill")
        }
    }

    @Binding public var show: Bool

    public init(title: String, style: Style, show: Binding<Bool>) {
        self.title = title
        self.style = style
        _show = show
    }

    public var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 8) {
                image
                    .foregroundStyle(style.color)
                    .foregroundStyle(.green)
                Text(title)
                    .font(.footnote)
                    .foregroundStyle(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(8)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            Spacer()
        }
        .offset(y: 16)
        .frame(width: 150)
        .padding(.horizontal, 32)
        .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
        .onTapGesture {
            withAnimation {
                show = false
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    show = false
                }
            }
        }
    }
}

public extension Snackbar {
    enum Style {
        case error
        case success
        
        var color: Color {
            switch self {
            case .error:
                return Color.red
            case .success:
                return Color.green
            }
        }
        
    }
}

private struct Overlay<T: View>: ViewModifier {
    @Binding var show: Bool
    let overlayView: T

    func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                overlayView
            }
        }
    }
}

public extension View {
    func overlay<T: View>(overlayView: T, show: Binding<Bool>) -> some View {
        modifier(Overlay(show: show, overlayView: overlayView))
    }

    func snackbar(message: String, style: Snackbar.Style, show: Binding<Bool>) -> some View {
        modifier(Overlay(show: show, overlayView: Snackbar(title: message, style: style, show: show)))
    }
}

struct TestView: View {
    @State var isShow: Bool = true
    var body: some View {
        Snackbar(title: "Test", style: .error, show: $isShow)
    }
}

#Preview {
    TestView()
}
