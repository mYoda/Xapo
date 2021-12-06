// XapoTest
//
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
//


import Foundation
import UIKit


extension UIEdgeInsets {
    
    public init(uniform value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }
    
    public init(horizontal h: CGFloat, vertical v: CGFloat) {
        self.init(top: v, left: h, bottom: v, right: h)
    }
    
    public init(top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }
}
