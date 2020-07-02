import SwiftUI

public enum BottomSheetViewState {
    case peek
    case half
    case full
}

@available(iOS 13.0, macOS 10.15, *)
public struct BottomSheet<Content>: View where Content: View {
    @GestureState private var gestureTranslation: CGFloat = 0
    @Binding private var viewState: BottomSheetViewState

    private var content: Content

    private var peekHeight: CGFloat
    private var halfHeight: CGFloat
    private var fullHeight: CGFloat

    private var offset: CGFloat {
        get {
            switch viewState {
            case .peek:
                return fullHeight - peekHeight
            case .half:
                return fullHeight - halfHeight
            case .full:
                return 50
            }
        }
    }

    private func updateViewState(translationHeight: CGFloat) {
        if translationHeight < 0 {
            if self.viewState == .peek {
                self.viewState = .half
            } else {
                self.viewState = .full
            }
        } else {
            if self.viewState == .full {
                self.viewState = .half
            } else {
                self.viewState = .peek
            }
        }
    }

    public init(viewState: Binding<BottomSheetViewState>, @ViewBuilder content: () -> Content) {
        self.content = content()

        self._viewState = viewState

        self.fullHeight = UIScreen.main.bounds.height
        self.peekHeight = fullHeight * 0.12
        self.halfHeight = fullHeight * 0.37
    }

    public var body: some View {
        VStack(spacing: 0) {
            BottomSheetDragIndicator()
                .padding(.top, 5)
                .padding(.bottom, 8)

            self.content
        }
        .frame(width: UIScreen.main.bounds.width, height: self.fullHeight, alignment: .top)
        .background(Color(.systemBackground))
        .cornerRadius(6)
        .offset(y: max(self.offset + self.gestureTranslation, 0))
        .animation(.interactiveSpring())
        .gesture(
            DragGesture()
                .updating(self.$gestureTranslation) { value, state, _ in state = value.translation.height }
                .onEnded { value in self.updateViewState(translationHeight: value.translation.height) }
        )
            .edgesIgnoringSafeArea(.bottom)
    }
}
