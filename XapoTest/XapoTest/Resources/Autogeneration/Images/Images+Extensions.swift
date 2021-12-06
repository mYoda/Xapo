import Foundation
// XapoTest
//
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
//


import SwiftUI
import UIKit

extension Design {
    /**
     Finding an asset in current Bundle with a given name.

     - Parameter name: The name of the asset.

     - Parameter placeholder: Asset that will be used by default.

     - Returns: Asset if exist otherwise - given placeholder.
     */
    static func find(byName name: String, placeholder: AssetImageTypeAlias = Design.Placeholders.noImage) -> AssetImageTypeAlias {
        guard UIImage(named: name) != nil else {
            #if DEBUG
            fatalError("ERROR: Assets Catalog doesn't contain an asset with a name: \(name)")
            #else
            log("ERROR: Assets Catalog doesn't contain an asset with a name: \(name)")
            return placeholder
            #endif
        }
        return ImageAsset(name: name).image
    }
}
