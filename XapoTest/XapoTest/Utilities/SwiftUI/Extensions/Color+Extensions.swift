// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI
import UIKit


extension Color {
    static var random: Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }
    
    static var uniformRandom: Color {
        let random: Double = .random(in: 0...1)
        return Color(red: random,
                     green: random,
                     blue: random)
    }
    
    /// returns UIColor(self)
    var uiColor: UIColor {
        return UIColor(self)
    }
}

extension UIColor {
    /// returns Color(self)
    var swui: Color {
        return Color(self)
    }
}
