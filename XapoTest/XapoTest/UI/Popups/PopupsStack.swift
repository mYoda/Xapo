// XapoTest
//    
// Created by Anton Nechayuk © 
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI

/**
Wrapper for the views to be able to recieve popup on. Embeds a PopupsContext in the environment for the underlying views to push popups

The context can be extracted with this line in the subviews declaration

    @EnvironmentObject var popupsContext: PopupsContext

- See also: PopupsContext
*/
struct PopupsStack: View {
    
    @ObservedObject var popupsContext: PopupsContext
    
    init(context: PopupsContext? = nil) {
        self.popupsContext = context ?? PopupsContext()
    }
    
    func removePopup(popup: PopupModel) {
        popupsContext.removePopup(id: popup.id)
    }
    
    var body: some View {
        return ZStack {
            ForEach(popupsContext.popups, id: \.id) { popup in
                PopupView(popup: popup, onHide: { model in
                    self.removePopup(popup: model)
                    model.onClose?()
                }).zIndex(1)
            }
        }
    }
}
