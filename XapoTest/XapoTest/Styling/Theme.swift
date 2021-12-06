// XapoTest
//
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
//


import Foundation
import SwiftUI



//MARK: - Form spaces, paddings, offsets, etc.
extension CGFloat {
    ///2
    static let formNanoPadding       : CGFloat = 2
    ///4
    static let formMicroPadding      : CGFloat = 4
    ///8
    static let formSmallPadding      : CGFloat = 8
    ///12
    static let formPadding           : CGFloat = 12
    ///16
    static let formMiddlePadding     : CGFloat = 16
    ///24
    static let formExtraPadding      : CGFloat = 24
    ///28
    static let formLargePadding      : CGFloat = 28
    ///36
    static let formExtraLargePadding : CGFloat = 36
    ///52
    static let formHugePadding       : CGFloat = 52
}


//MARK: - Spaces, paddings, offsets, etc.
extension CGFloat {
    ///0.5
    static let borderWidth           : CGFloat = 0.5
    ///0.5
    static let separator             : CGFloat = 0.5
    ///2
    static let gap                   : CGFloat = 3
    ///15
    static let wideSeparator         : CGFloat = 15
    ///4
    static let nanoPadding           : CGFloat = 4
    ///10
    static let microPadding          : CGFloat = 10
    ///16
    static let smallPadding          : CGFloat = 16
    ///20
    static let padding               : CGFloat = 20
    ///24
    static let middlePadding         : CGFloat = 24
    ///30
    static let extraPadding          : CGFloat = 30
    ///40
    static let largePadding          : CGFloat = 40
    ///50
    static let extraLargePadding     : CGFloat = 50
    ///60
    static let hugePadding           : CGFloat = 60
    ///40
    static let smallButtonHeight     : CGFloat = 40
    ///46
    static let defaultButtonHeight   : CGFloat = 46
    ///7
    static let lineSpacing           : CGFloat = 7
    ///5
    static let smallLineSpacing      : CGFloat = 5
    ///3
    static let narrowLineSpacing     : CGFloat = 3
    ///49 + safe bottom space
    static var tabBarHeight          : CGFloat { 49 + .safeBottom }
    ///50 + safe bottom space
    static var tabBarHeightPad       : CGFloat { 50 + .safeBottom }
    ///45
    static let minKeyboardOffset     : CGFloat = 45
    ///8
    static let smallCornerRadius     : CGFloat = 8
    ///10
    static let cornerRadius          : CGFloat = 10
    ///12
    static let mediumCornerRadius    : CGFloat = 12
    ///16
    static let middleCornerRadius    : CGFloat = 16
    ///20
    static let smallElementHeight    : CGFloat = 20
    ///44
    static let textFieldHeight      : CGFloat = 44
    ///44
    static let higElementHeight      : CGFloat = 44
    ///50
    static let elementHeight         : CGFloat = 50
    ///60
    static let increasedElementHeight: CGFloat = 60
    ///70
    static let largeElementHeight    : CGFloat = 70

    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    static var safeScreenHeight: CGFloat {
        return CGSize.safeScreenSize.height
    }
    
    static var safeLeft: CGFloat {
        return UIWindow.safeInsets.left
    }
    
    static var safeRight: CGFloat {
        return UIWindow.safeInsets.right
    }
    
    static var safeTop: CGFloat {
        return UIWindow.safeInsets.top
    }
    
    static var safeBottom: CGFloat {
        return UIWindow.safeInsets.bottom
    }
    
    static var safeHorizontal: CGFloat {
        return safeLeft + safeRight
    }
}

//MARK: - Sizes
extension CGSize {
    static var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    @usableFromInline
    static var safeScreenSize: CGSize {
        let w = screenSize.width - CGFloat.safeLeft - CGFloat.safeRight
        let h = screenSize.height - CGFloat.safeTop - CGFloat.safeBottom
        return CGSize(width: w, height: h)
    }
}

//MARK: - Navigation bar
extension CGFloat {
    
    enum NavigationBarDisplayMode {
        
        ///0
        case none
        ///44
        case `default`
        ///96
        case largeTitle
        case custom(CGFloat)
        
        var height: CGFloat {
            switch self {
                case .none: return 0
                case .default: return 44
                case .largeTitle: return 96
                case .custom(let height): return height
            }
        }
    }
    
    enum TabBarDisplayMode {
        /// safeBottom
        case none
        /// 49 + safe bottom space
        case `default`
        case custom(CGFloat)
        
        var height: CGFloat {
            switch self {
                case .none: return CGFloat.safeBottom
                case .default: return CGFloat.tabBarHeight
                case .custom(let height): return height
            }
        }
    }
    
    /**
     - parameters:
       - navigationBarMode: .none (0) | .default(44) | .largeTitle(96) | .custom(CGFloat)
       - tabBarMode: .none (CGFloat.safeBottom) | .default(CGFloat.tabBarHeight) | .custom(CGFloat)
     */
    static func contentHeight(navigationBarMode: NavigationBarDisplayMode = .none, tabBarMode: TabBarDisplayMode = .none) -> CGFloat {
        return CGFloat.screenHeight - CGFloat.safeTop - navigationBarMode.height - tabBarMode.height
    }
}


extension CGFloat {
    /**
        The scaled height related to the height of the current Device's `Screen`.

        Computation depends on the safeArea flag, and is
        equivalent to:

        
        // isSafeArea equal to `true`:
        let result =  CGFloat.safeScreenHeight * scale

        // isSafeArea equal to `false`:
        let result =  CGFloat.screenHeight * scale
       
    */
    static func heightFromScreen(scale: CGFloat, isSafeArea: Bool = false) -> CGFloat {
        return isSafeArea ? .safeScreenHeight * scale : .screenHeight * scale
    }
    
    static func widthFromScreen(scale: CGFloat) -> CGFloat {
        return   .screenWidth * scale
    }
}
