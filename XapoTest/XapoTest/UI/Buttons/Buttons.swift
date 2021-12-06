// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI


enum Buttons {}


//MARK: - Rectangle buttons
extension Buttons {
    
    enum BackgroundType {
        case fill
        case stroke
    }
    
    static func rectangle(title: String,
                          font: Font = Font.system(size: 14, weight: .medium),
                          textColor: Color = Color.blackText,
                          disabledTextColor: Color = Color.disabledGray,
                          backgroundColor: Color = Color.white,
                          disabledBackgroundColor: Color = Color.disabledGray.opacity(0.25),
                          insets: EdgeInsets = EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20),
                          cornerRadius: CGFloat = .cornerRadius,
                          backgroundType: BackgroundType = .fill,
                          action: @escaping () -> Void) -> some View {
        
        Buttons.rectangle(label: { Text(title) },
                          font: font,
                          textColor: textColor,
                          disabledTextColor: disabledTextColor,
                          backgroundColor: backgroundColor,
                          disabledBackgroundColor: disabledBackgroundColor,
                          insets: insets,
                          cornerRadius: cornerRadius,
                          backgroundType: backgroundType,
                          action: action)
    }
    
    static func sizedRectangle(
        title: String,
        minWidth: CGFloat? = nil,
        width: CGFloat? = nil,
        maxWidth: CGFloat? = .infinity,
        minHeight: CGFloat? = nil,
        height: CGFloat? = nil,
        maxHeight: CGFloat? = .infinity,
        font: Font = Font.system(size: 17, weight: .medium),
        textColor: Color = Color.blackText,
        disabledTextColor: Color = Color.disabledGray,
        backgroundColor: Color = Color.white,
        disabledBackgroundColor: Color = Color.disabledGray.opacity(0.25),
        cornerRadius: CGFloat = .cornerRadius,
        backgroundType: BackgroundType = .fill,
        action: @escaping () -> Void) -> some View {
            
            Buttons.sizedRectangle(label: { Text(title) },
                                   minWidth: minWidth,
                                   width: width,
                                   maxWidth: maxWidth,
                                   minHeight: minHeight,
                                   height: height,
                                   maxHeight: maxHeight,
                                   font: font,
                                   textColor: textColor,
                                   disabledTextColor: disabledTextColor,
                                   backgroundColor: backgroundColor,
                                   disabledBackgroundColor: disabledBackgroundColor,
                                   cornerRadius: cornerRadius,
                                   backgroundType: backgroundType,
                                   action: action)
        }
    
    
    static func strokedRectangle(
        title: String,
        insets: EdgeInsets = EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20),
        font: Font = Font.system(size: 17, weight: .medium),
        minimumFontScale: CGFloat = 1.0,
        textColor: Color = Color.blackText,
        disabledTextColor: Color = Color.disabledGray,
        backgroundColor: Color = Color.white,
        disabledBackgroundColor: Color = Color.disabledGray.opacity(0.25),
        strokeColor: Color = Color.black,
        lineWidth: CGFloat = 2,
        cornerRadius: CGFloat = .cornerRadius,
        backgroundType: BackgroundType = .fill,
        isSelected: Bool = false,
        action: @escaping () -> Void) -> some View {
            
            Buttons.strokedRectangle(label: { Text(title) },
                                     insets: insets,
                                     font: font,
                                     minimumFontScale: minimumFontScale,
                                     textColor: textColor,
                                     disabledTextColor: disabledTextColor,
                                     backgroundColor: backgroundColor,
                                     disabledBackgroundColor: disabledBackgroundColor,
                                     strokeColor: strokeColor,
                                     lineWidth: lineWidth,
                                     cornerRadius: cornerRadius,
                                     backgroundType: backgroundType,
                                     isSelected: isSelected,
                                     action: action)
        }
    
    
}


//MARK: - General rectangle buttons
extension Buttons {
    
    static func rectangle<Label: View>(@ViewBuilder label: () -> Label,
                                       font: Font = Font.system(size: 14, weight: .medium),
                                       textColor: Color = Color.blackText,
                                       disabledTextColor: Color = Color.disabledGray,
                                       backgroundColor: Color = Color.white,
                                       disabledBackgroundColor: Color = Color.disabledGray.opacity(0.25),
                                       insets: EdgeInsets = EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20),
                                       cornerRadius: CGFloat = .cornerRadius,
                                       backgroundType: BackgroundType = .fill,
                                       action: @escaping () -> Void) -> some View {
        
        Button(action: action, label: label).buttonStyle(
            CustomizableButtonStyle { config, isEnabled in
                config.label
                    .font(font)
                    .foregroundColor(isEnabled ? textColor : disabledTextColor)
                    .padding(insets)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .apply(backgroundType == .fill, apply: {
                                $0.fill(isEnabled ? backgroundColor : disabledBackgroundColor)
                            }, otherwise: {
                                $0.stroke(isEnabled ? backgroundColor : disabledBackgroundColor)
                            })
                            .padding(CGFloat.borderWidth)
                    )
                    .compositingGroup()
                    .opacity(config.isPressed ? 0.7 : 1.0)
                    .scaleEffect(config.isPressed ? 0.97 : 1.0)
                    .contentShape(Rectangle())
                    .asAnyView
            }
        )
    }
    
    static func sizedRectangle<Label: View>(@ViewBuilder label: () -> Label,
                                            minWidth: CGFloat? = nil,
                                            width: CGFloat? = nil,
                                            maxWidth: CGFloat? = .infinity,
                                            minHeight: CGFloat? = nil,
                                            height: CGFloat? = nil,
                                            maxHeight: CGFloat? = .infinity,
                                            font: Font = Font.system(size: 17, weight: .medium),
                                            textColor: Color = Color.blackText,
                                            disabledTextColor: Color = Color.disabledGray,
                                            backgroundColor: Color = Color.white,
                                            disabledBackgroundColor: Color = Color.disabledGray.opacity(0.25),
                                            cornerRadius: CGFloat = .cornerRadius,
                                            backgroundType: BackgroundType = .fill,
                                            action: @escaping () -> Void) -> some View {
        
        Button(action: action, label: label).buttonStyle(
            CustomizableButtonStyle { config, isEnabled in
                config.label
                    .font(font)
                    .foregroundColor(isEnabled ? textColor : disabledTextColor)
                    .frame(minWidth: minWidth, idealWidth: width, maxWidth: maxWidth, minHeight: minHeight, idealHeight: height, maxHeight: maxHeight)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .apply(backgroundType == .fill, apply: {
                                $0.fill(isEnabled ? backgroundColor : disabledBackgroundColor)
                            }, otherwise: {
                                $0.stroke(isEnabled ? backgroundColor : disabledBackgroundColor)
                            })
                    )
                    .opacity(config.isPressed ? 0.7 : 1.0)
                    .compositingGroup()
                    .asAnyView
            }
        )
    }
    
    
    static func strokedRectangle<Label: View>(@ViewBuilder label: () -> Label,
                                              insets: EdgeInsets = EdgeInsets(top: 15, leading: 20, bottom: 12, trailing: 20),
                                              font: Font = Font.system(size: 17, weight: .medium),
                                              minimumFontScale: CGFloat = 1.0,
                                              textColor: Color = Color.blackText,
                                              disabledTextColor: Color = Color.disabledGray,
                                              backgroundColor: Color = Color.white,
                                              disabledBackgroundColor: Color = Color.disabledGray.opacity(0.25),
                                              strokeColor: Color = Color.black,
                                              lineWidth: CGFloat = 1,
                                              cornerRadius: CGFloat = .cornerRadius,
                                              backgroundType: BackgroundType = .fill,
                                              isSelected: Bool,
                                              action: @escaping () -> Void) -> some View {
        
        Button(action: action, label: label).buttonStyle(
            CustomizableButtonStyle { config, isEnabled in
                config.label
                    .font(font)
                    .lineLimit(1)
                    .foregroundColor(isEnabled ? textColor : disabledTextColor)
                    .minimumScaleFactor(minimumFontScale)
                    .padding(insets)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .apply(backgroundType == .fill, apply: {
                                $0.fill(isEnabled ? ((config.isPressed || isSelected) ? backgroundColor : backgroundColor.opacity(0.3)) : disabledBackgroundColor)
                            }, otherwise: {
                                $0.stroke(isEnabled ? backgroundColor : disabledBackgroundColor)
                            })
                    )
                    .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(strokeColor, lineWidth: lineWidth))
                    .opacity(config.isPressed ? 0.7 : 1.0)
                    .compositingGroup()
                    .asAnyView
            }
        )
    }
}


//MARK: - Text buttons
extension Buttons {

static func text(title: String,
                 font: Font = .system(size: 16, weight: .regular),
                 kerning: CGFloat = 0,
                 textColor: Color = Color.black,
                 disabledTextColor: Color = Color.gray,
                 underline: Bool = false,
                 action: @escaping () -> Void) -> some View {
    
    Button(action: action, label: {
        Text(title).kerning(kerning).applyIf(underline, apply: { $0.underline() })
    }).buttonStyle(
        CustomizableButtonStyle { config, isEnabled in
            config.label
                .font(font)
                .foregroundColor(isEnabled ? textColor : disabledTextColor)
                .compositingGroup()
                .opacity(config.isPressed ? 0.7 : 1.0)
                .contentShape(Rectangle())
                .asAnyView
        }
    )
}
}



extension Buttons {
    struct ColoredButtons: View {
        
        let isActive: Bool
        let text: String
        let color: Color
        let radius: CGFloat = 30
        let action: () -> Void
        
        var body: some View {
            VStack{
                Button(action: {
                    action()
                }) {
                    Text(text)
                        .font(.xapoSecretFont(size: 20, weight: .medium))
                        .foregroundColor(Color.whiteText)
                        .frame(minWidth: 50)
                        .padding(.vertical, .formPadding)
                        .padding(.horizontal, .padding)
                        .background(RoundedRectangle(cornerRadius: radius).fill(color).opacity(isActive ? 1.0 : 0.3))
                        .overlay(RoundedRectangle(cornerRadius: radius).stroke(color, lineWidth: 2))
                }
            }
        }
    }
}
