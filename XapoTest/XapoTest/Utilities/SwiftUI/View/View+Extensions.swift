import Foundation
import SwiftUI

extension View {
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    /// ```
    /// Text("Label")
    ///     .isHidden(true)
    /// ```
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    @ViewBuilder func isHidden(_ hidden: Bool, animated: Bool = true) -> some View {
        
        if hidden {
            if animated {
                withAnimation(.easeOut) {
                    self.hidden()
                }
            } else {
                self.hidden()
            }
            
        } else {
            if animated {
                withAnimation {
                    self
                }
            } else {
                self
            }
        }
    }
}


extension View {
    func offset(size: CGSize) -> some View {
        offset(x: size.width, y: size.height)
    }
    
    func scaleEffect(_ scale: CGFloat) -> some View {
        scaleEffect(x: scale, y: scale)
    }
    
    func padding(horizontal: CGFloat, vertical: CGFloat) -> some View {
        padding(EdgeInsets(horizontal: horizontal, vertical: vertical))
    }
}


struct FontWithLineHeight: ViewModifier {
    let font: UIFont
    let lineHeight: CGFloat

    func body(content: Content) -> some View {
        content
            .font(Font(font))
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, (lineHeight - font.lineHeight) / 2)
    }
}

// MARK: - Add with Extension
extension View {
    func fontWithLineHeight(font: UIFont, lineHeight: CGFloat) -> some View {
        ModifiedContent(content: self, modifier: FontWithLineHeight(font: font, lineHeight: lineHeight))
    }
}
