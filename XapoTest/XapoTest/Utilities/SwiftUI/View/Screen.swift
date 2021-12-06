import Foundation
import SwiftUI


func Screen<Content: View>(
    color: Color = .white,
    ignoreKeyboard: Bool = false,
    alignment: Alignment = .center,
    @ViewBuilder content: @escaping () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            color.edgesIgnoringSafeArea(.all)
            content()
        }
        .applyIf(ignoreKeyboard) { view in
            view.frame(size: CGSize.safeScreenSize)
                .position(CGSize.safeScreenSize.center)
                .ignoresSafeArea(.keyboard)
        }
    }


func Screen<Content: View>(
    background: Image,
    ignoreKeyboard: Bool = false,
    @ViewBuilder content: @escaping () -> Content) -> some View {
    
    ZStack {
        background.resizable()
            .scaledToFill()
            .greedyFrame(alignment: .center)
        content()
    }
    .applyIf(ignoreKeyboard) { view in
        view.frame(size: CGSize.safeScreenSize)
            .position(CGSize.safeScreenSize.center)
            .ignoresSafeArea(.keyboard)
    }
}
