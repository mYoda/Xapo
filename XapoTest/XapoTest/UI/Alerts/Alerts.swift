// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import UIKit


struct Alert {
    
    static func showComingSoon() {
        showAlert(title: String.General.fire, message: String.General.comingSoon)
    }
    
    static func showError(error: Error, userFriendlyMessage: String? = nil) {
        let message: String
        #if DEBUG
        message = error.localizedDescription
        #else
        message = userFriendlyMessage ?? error.localizedDescription
        #endif
        showAlert(title: String.Error.error, message: message)
    }
    
    static func showAlert(title: String? = nil, message: String, action: (() -> Void)? = nil) {
        async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(.ok(action))
            alert.present()
        }
    }
}
