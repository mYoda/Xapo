// XapoTest
//
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
//


import Foundation
import Combine
import UIKit


enum Navigation: Equatable {
    
    case launch
    case welcome
    case main
    
    var isStatusBarHidden: Bool {
        switch self {
            default: return false
        }
    }
    
    var isEnter: Bool {
        switch self {
            case .launch: return true
            case .welcome: return true
            case .main: return false
        }
    }
    
    var statusBarSyle: UIStatusBarStyle {
        switch self {
            default:
                return .lightContent
        }
    }
    
    static let current = CurrentValueSubject<Navigation,Never>(Navigation.launch)
    static let showLaunchOverlay = CurrentValueSubject<Bool,Never>(false)
    
    static func == (lhs: Navigation, rhs: Navigation) -> Bool {
        switch (lhs,rhs) {
            case (.welcome, .welcome): return true
            case (.launch, .launch): return true
            case (.main, .main): return true
            default: return false
        }
    }
}
