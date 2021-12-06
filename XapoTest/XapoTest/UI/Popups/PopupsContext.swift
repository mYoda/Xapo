// XapoTest
//    
// Created by Anton Nechayuk © 
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI

/**
Context used to publish popups

- Tag: PopupsContext
*/
final class PopupsContext: ObservableObject {
    
    @Published var popups: [PopupModel] = []
        
    /**
    Add popup with custom content view
    */
    func addPopup<Content: View>(@ViewBuilder
        content: @escaping (_ id: UUID, _ hideAction: () -> Void) -> Content) {
        let popup = PopupModel(content: content)
        self.addPopup(popup: popup)
    }
    
    func addPopup(popup: PopupModel) {
        DispatchQueue.main.async {
            self.popups.append(popup)
        }
    }
    
    func removePopup(id: UUID) {
        popups.removeAll(where: { $0.id == id })
    }
}
