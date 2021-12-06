// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI

struct Primitives {
    
    ///Horizontal line
    @inlinable
    static var separator: some View {
        separator(color: Color.separator)
    }
    
    static var formSeparator: some View {
        separator(color: Color.separator).padding(.horizontal, CGFloat.formMiddlePadding)
    }
    
    static func separator(color: Color = .separator, height: CGFloat = .separator) -> some View {
        Rectangle().fill(color)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: height, maxHeight: height, alignment: .leading)
    }
    
    ///Vertical line
    static var divider: some View {
        divider(color: Color.separator)
    }

    static func divider(color: Color) -> some View {
        Rectangle().fill(color)
            .frame(minWidth: .separator, maxWidth: .separator, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
    
    ///Other
    static func dot(color: Color = .accent, diameter: CGFloat = 8) -> some View {
        return Circle().fill(color).frame(size: CGSize(uniform: diameter))
    }
    
    static var handle: some View {
        VStack {
            Spacer(minLength: 0)
            HStack {
                Spacer(minLength: 0)
                RoundedRectangle(cornerRadius: 2.5)
                    .foregroundColor(Color.handle)
                    .frame(width: 36.0, height: 5.0)
                Spacer(minLength: 0)
            }
        }
        .frame(height: 13)
    }
    
    static func handle(contentOffset: Binding<CGFloat>) -> some View {
        let opacity = Math.lerp(from: 1, to: 0, progress: Double(contentOffset.wrappedValue / 20))
        
        return handle
            .greedyHeight(alignment: .top)
            .opacity(opacity)
    }
    
    /// ActivityIndicator() / spinner
    static var spinner: some View {
        ActivityIndicator()
    }
    
    
    static var checkmark: some View {
        Design.Icons.checkmark
            .renderingMode(.template)
            .foregroundColor(.grayText)
    }
}
