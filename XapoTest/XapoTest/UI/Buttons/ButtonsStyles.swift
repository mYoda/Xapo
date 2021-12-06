// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI


struct RoundRectStyle: ButtonStyle {
    let fontColor: Color
    let disabledFontColor: Color
    let backgroundColor: Color
    let disabledBackgroundColor: Color
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    
    init(fontColor: Color,
         disabledFontColor: Color? = nil,
         backgroundColor: Color,
         disabledBackgroundColor: Color? = nil,
         width: CGFloat = 150,
         height: CGFloat = 50,
         cornerRadius: CGFloat = CGFloat.cornerRadius) {
        
        self.fontColor = fontColor
        self.disabledFontColor = disabledFontColor ?? backgroundColor.opacity(0.6)
        self.backgroundColor = backgroundColor
        self.disabledBackgroundColor = disabledBackgroundColor ?? backgroundColor.opacity(0.1)
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
    }
    
    public func makeBody(configuration: RoundRectStyle.Configuration) -> some View {
        return RoundRectButton(fontColor: fontColor,
                               disabledFontColor: disabledFontColor,
                               backgroundColor: backgroundColor,
                               disabledBackgroundColor: disabledBackgroundColor,
                               width: width,
                               height: height,
                               cornerRadius: cornerRadius,
                               configuration: configuration)
    }
    
    private struct RoundRectButton: View {
        let fontColor: Color
        let disabledFontColor: Color
        let backgroundColor: Color
        let disabledBackgroundColor: Color
        let width: CGFloat
        let height: CGFloat
        let cornerRadius: CGFloat
        let configuration: ButtonStyle.Configuration
        
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        var body: some View {
            configuration.label
            .foregroundColor(isEnabled ? fontColor : disabledFontColor)
            .frame(width: width, height: height)
            .background(RoundedRectangle(cornerRadius: cornerRadius)
            .fill(isEnabled ? backgroundColor : disabledBackgroundColor))
            .compositingGroup()
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
        }
    }
}


struct TextButtonStyle: ButtonStyle {
    
    public func makeBody(configuration: Configuration) -> some View {
        TextButton(configuration: configuration, font: font, textColor: textColor)
    }
    
    private let font: Font
    private let textColor: Color
    
    init(font: Font = Font.system(size: 17, weight: .semibold),
         textColor: Color = Color.blackText) {
        
        self.font = font
        self.textColor = textColor
    }
    
    struct TextButton: View {
        let configuration: ButtonStyle.Configuration
        let font: Font
        let textColor: Color
        
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        var body: some View {
            configuration.label
                .font(font)
                .foregroundColor(isEnabled ? textColor : Color.disabledGray)
                .compositingGroup()
                .opacity(configuration.isPressed ? 0.7 : 1.0)
        }
    }
}



struct CustomizableButtonStyle: ButtonStyle {
    
    let customization: (_ configuration: ButtonStyle.Configuration, _ isEnabled: Bool) -> AnyView
    

    public func makeBody(configuration: RoundRectStyle.Configuration) -> some View {
        return CustomButton(customization: customization, configuration: configuration)
    }
    
    private struct CustomButton: View {
        
        let customization: (_ configuration: ButtonStyle.Configuration, _ isEnabled: Bool) -> AnyView
        let configuration: ButtonStyle.Configuration
        
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        var body: some View {
            customization(configuration, isEnabled)
        }
    }
}
