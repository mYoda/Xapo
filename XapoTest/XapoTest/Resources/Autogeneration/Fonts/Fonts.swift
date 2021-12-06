// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
//
// Template Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
//


#if os(OSX)
import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
import UIKit.UIFont
#endif
import SwiftUI

// MARK: - Fonts

/// To register Fonts use: FontRegistrator.registerAllCustomFonts() in AppDelegate
/// Or add all them to the your Info.plist file


// MARK: - XapoSecretFont

internal enum XapoSecretFont {
    /*
     <string>Xapo-Secret-Black.otf</string>
     <string>Xapo-Secret-Bold.otf</string>
     <string>Xapo-Secret-Light.otf</string>
     <string>Xapo-Secret-Medium.otf</string>
     <string>Xapo-Secret-Regular.otf</string>
     */

    enum FontStyle {
        case black
        case bold
        case light
        case medium
        case regular

        var name: String {
            switch self {
                case .black: return "Xapo-Secret-Black"
                case .bold: return "Xapo-Secret-Bold"
                case .light: return "Xapo-Secret-Light"
                case .medium: return "Xapo-Secret-Medium"
                case .regular: return "Xapo-Secret-Regular"
            }
        }
        var path: String {
            switch self {
                case .black: return "Xapo-Secret-Black.otf"
                case .bold: return "Xapo-Secret-Bold.otf"
                case .light: return "Xapo-Secret-Light.otf"
                case .medium: return "Xapo-Secret-Medium.otf"
                case .regular: return "Xapo-Secret-Regular.otf"
            }
        }
        static var allCases: [FontStyle] {
            return [.black, .bold, .light, .medium, .regular]
        }
    }   
}


extension Font {
    /// XapoSecretFont Family
    internal static func xapoSecretFont(size: CGFloat, weight: XapoSecretFont.FontStyle) -> Font {
        return getFont(name: weight.name, size: size)
    }

    fileprivate static func getFont(name: String, size: CGFloat) -> Font {
        return Font.custom(name, size: size)
    }
}

extension UIFont {
    /// XapoSecretFont Family
    internal static func xapoSecretFont(size: CGFloat, weight: XapoSecretFont.FontStyle) -> UIFont {
        return getFont(name: weight.name, size: size)
    }

    fileprivate static func getFont(name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size)
        else {
            fatalError("⛑⛑⛑⛑⛑ \nERROR: UIFont with name: \(name) is not found! \n⛑⛑⛑⛑⛑")
        }
        return font
    }
}



internal enum FontRegistrator {
    internal static func registerAllCustomFonts() {
        XapoSecretFont.FontStyle.allCases.forEach { FontRegistrator.register(path: $0.path) }
    }
    private static func register(path: String) {
        guard let url = path.url else { return }
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
    }
}


fileprivate extension String {
    var url: URL? {
        return BundleToken.bundle.url(forResource: self, withExtension: nil)
    }
}

// MARK: - Implementation Details


private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: BundleToken.self)
        #endif
    }()
}


extension UIFont {
    public static func printAll() {
        for family in UIFont.familyNames.sorted() {
            print("Font family: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("- Font name: \(name)")
            }
        }
    }
}
