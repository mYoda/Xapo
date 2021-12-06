// XapoTest
//    
// Created by Anton Nechayuk © 
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI
import Combine


struct Global {
    static let rootPopupsContext = PopupsContext()
    static let overlaysBroker = OverlaysBroker()
}


//MARK: - Actions
extension Global {
    @discardableResult
    static func addLoadingOverlay() -> UUID {
        return Global.overlaysBroker.addOverlay(view: XapoLoadingOverlay())
    }
    
    static func removeLoadingOverlay(_ id: UUID? = nil) {
        if let id = id {
            Global.overlaysBroker.removeOverlay(id: id)
        } else {
            Global.overlaysBroker.removeAll()
        }
    }
}
