// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
//
// Template Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
//


#if os(OSX)
  import AppKit.NSImage
   typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import SwiftUI
   typealias AssetImageTypeAlias = Image
#endif



// MARK: - Catalog

enum Design {
    enum Brand {
          static let xapoLogo = ImageAsset(name: "Brand/Xapo_logo").image
    }
    enum Icons {
        static let arrowCircleRight = ImageAsset(name: "ArrowCircle_right").image
        static let arrowBack = ImageAsset(name: "Arrow_back").image
        static let arrowNext = ImageAsset(name: "Arrow_next").image
        static let bankAccounts = ImageAsset(name: "BankAccounts").image
        static let checkboxOFF = ImageAsset(name: "Checkbox_OFF").image
        static let checkboxON = ImageAsset(name: "Checkbox_ON").image
        static let checkmark = ImageAsset(name: "Checkmark").image
        static let checkmarkGradientCircle = ImageAsset(name: "CheckmarkGradientCircle").image
        static let chevronDown = ImageAsset(name: "Chevron_down").image
        static let chevronNext = ImageAsset(name: "Chevron_next").image
        static let chevronRight = ImageAsset(name: "Chevron_right").image
        static let clear = ImageAsset(name: "Clear").image
        static let close = ImageAsset(name: "Close").image
        static let dev = ImageAsset(name: "Dev").image
        static let gridLine = ImageAsset(name: "Grid-line").image
        static let list = ImageAsset(name: "List").image
        static let lock = ImageAsset(name: "Lock").image
        static let mail = ImageAsset(name: "Mail").image
        static let menu = ImageAsset(name: "Menu").image
        static let more = ImageAsset(name: "More").image
        static let moreCircle = ImageAsset(name: "More_circle").image
        static let remove = ImageAsset(name: "Remove").image
        static let star = ImageAsset(name: "star").image
    }
    enum Placeholders {
          static let noImage = ImageAsset(name: "Placeholders/NoImage").image
    }
}

// MARK: - Implementation Details
struct ImageAsset {
  fileprivate(set) var name: String

  var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(name, bundle: bundle)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(name)
    #endif
    return image
  }
}

private final class BundleToken {}
