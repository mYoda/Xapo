// XapoTest
//
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
//


import Foundation
import UIKit


extension UIWindow {
    
    static var safeInsets: UIEdgeInsets {
        return current?.safeAreaInsets ?? .zero// UIEdgeInsets(top: 44, left: 0, bottom: 34, right: 0)
    }
        
    static var isFullScreen: Bool {
        return current?.frame == UIScreen.main.bounds
    }
}


extension UIWindow {
     
    ///If scene is not connected will return first normal level key window
    static var current: UIWindow? {
        return sceneActiveWindow ?? keyWindow
    }
    
    static var keyWindow: UIWindow? {
        var window = UIApplication.shared.windows.first { $0.isKeyWindow }
        if window == nil || window?.windowLevel != .normal {
            for w in UIApplication.shared.windows {
                if w.windowLevel == .normal {
                    window = w
                }
            }
        }
        return window
    }
    
    static var sceneActiveWindow: UIWindow? {
        let window = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows
            .filter({ $0.isKeyWindow && !$0.isKind(of: OverlayWindow.self) }).first
        return window
    }
}
