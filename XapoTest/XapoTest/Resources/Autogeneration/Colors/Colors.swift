// ••••••••••••••••••
// • GENERATED FILE FROM ASSETS •
// ••••••••••••••••••
//
// Template Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
//



import UIKit
import SwiftUI


internal extension Color {
    // • Colors.xcassets

    /// #ffffff 
	static let background = Color(name: "background")

    /// #2b374e 
	static let backgroundDark = Color(name: "backgroundDark")

    /// #222a38 alpha:(0.80)
	static let backgroundGray = Color(name: "backgroundGray")

    /// #fef7f2 
	static let backgroundOrangeLight = Color(name: "backgroundOrangeLight")

    /// #000000 alpha:(0.09)
	static let shadow = Color(name: "shadow")

    /// #000000 alpha:(0.20)
	static let handle = Color(name: "Handle")

    /// #0762f2 
	static let darkBlue = Color(name: "darkBlue")

    /// #e63f0c 
	static let red = Color(name: "red")

    /// #eafcf3 
	static let lightGreen = Color(name: "lightGreen")

    /// #f48026 
	static let orange = Color(name: "orange")

    /// #000000 alpha:(0.20)
	static let border = Color(name: "border")

    /// #e8ebef 
	static let separator = Color(name: "separator")

    /// #f1f1f1 
	static let lightGray = Color(name: "lightGray")

    /// #e1e1e1 
	static let strokeGray = Color(name: "strokeGray")

    /// #bdbdbd 
	static let regularGray = Color(name: "regularGray")

    /// #0079ff 
	static let accent = Color(name: "accent")

    /// #1e2434 
	static let blackAccent = Color(name: "blackAccent")

    /// #fc644b 
	static let coral = Color(name: "coral")

    /// #999999 
	static let disabledGray = Color(name: "disabledGray")

    /// #5bab7a 
	static let greenElement = Color(name: "greenElement")

    /// #f49626 
	static let orangeElement = Color(name: "orangeElement")

    /// #fc644b 
	static let coralElement = Color(name: "coralElement")

    /// #f4802f 
	static let orangeText = Color(name: "orangeText")

    /// #000000 
	static let blackText = Color(name: "blackText")

    /// #fc5255 
	static let redText = Color(name: "redText")

    /// #bcc0c5 
	static let placeholder = Color(name: "placeholder")

    /// #ffffff alpha:(0.75)
	static let lightGrayText = Color(name: "lightGrayText")

    /// #65b083 
	static let greenText = Color(name: "greenText")

    /// #916a59 
	static let brownText = Color(name: "brownText")

    /// #ffffff 
	static let whiteText = Color(name: "whiteText")

    /// #95908d 
	static let grayText = Color(name: "grayText")

    /// #494643 
	static let darkGrayText = Color(name: "darkGrayText")
}

internal extension UIColor {
    // • Colors.xcassets

    /// #ffffff 
	static let background = UIColor(name: "background")

    /// #2b374e 
	static let backgroundDark = UIColor(name: "backgroundDark")

    /// #222a38 alpha:(0.80)
	static let backgroundGray = UIColor(name: "backgroundGray")

    /// #fef7f2 
	static let backgroundOrangeLight = UIColor(name: "backgroundOrangeLight")

    /// #000000 alpha:(0.09)
	static let shadow = UIColor(name: "shadow")

    /// #000000 alpha:(0.20)
	static let handle = UIColor(name: "Handle")

    /// #0762f2 
	static let darkBlue = UIColor(name: "darkBlue")

    /// #e63f0c 
	static let red = UIColor(name: "red")

    /// #eafcf3 
	static let lightGreen = UIColor(name: "lightGreen")

    /// #f48026 
	static let orange = UIColor(name: "orange")

    /// #000000 alpha:(0.20)
	static let border = UIColor(name: "border")

    /// #e8ebef 
	static let separator = UIColor(name: "separator")

    /// #f1f1f1 
	static let lightGray = UIColor(name: "lightGray")

    /// #e1e1e1 
	static let strokeGray = UIColor(name: "strokeGray")

    /// #bdbdbd 
	static let regularGray = UIColor(name: "regularGray")

    /// #0079ff 
	static let accent = UIColor(name: "accent")

    /// #1e2434 
	static let blackAccent = UIColor(name: "blackAccent")

    /// #fc644b 
	static let coral = UIColor(name: "coral")

    /// #999999 
	static let disabledGray = UIColor(name: "disabledGray")

    /// #5bab7a 
	static let greenElement = UIColor(name: "greenElement")

    /// #f49626 
	static let orangeElement = UIColor(name: "orangeElement")

    /// #fc644b 
	static let coralElement = UIColor(name: "coralElement")

    /// #f4802f 
	static let orangeText = UIColor(name: "orangeText")

    /// #000000 
	static let blackText = UIColor(name: "blackText")

    /// #fc5255 
	static let redText = UIColor(name: "redText")

    /// #bcc0c5 
	static let placeholder = UIColor(name: "placeholder")

    /// #ffffff alpha:(0.75)
	static let lightGrayText = UIColor(name: "lightGrayText")

    /// #65b083 
	static let greenText = UIColor(name: "greenText")

    /// #916a59 
	static let brownText = UIColor(name: "brownText")

    /// #ffffff 
	static let whiteText = UIColor(name: "whiteText")

    /// #95908d 
	static let grayText = UIColor(name: "grayText")

    /// #494643 
	static let darkGrayText = UIColor(name: "darkGrayText")
}

// MARK: - Implementation Details
fileprivate extension UIColor {
    convenience init(name: String) {
        self.init(named: name, in: bundle, compatibleWith: nil)!
    }
}

fileprivate extension Color {
    init(name: String) {
        self.init(name, bundle: bundle)
    }
}

private let bundle = BundleToken.bundle
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}