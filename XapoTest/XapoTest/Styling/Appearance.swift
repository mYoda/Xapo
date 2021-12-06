// XapoTest
//    
// Created by Anton Nechayuk © 
// with 🧡 for Xapo in 2021
// 


import Foundation
import UIKit
import SwiftUI
import Combine


enum Appearance {}


//MARK: - Status Bar
extension Appearance {
    private static var cancellables: Set<AnyCancellable> = []
    
    struct StatusBar {
        let style = CurrentValueSubject<UIStatusBarStyle, Never>(UIStatusBarStyle.default)
        let isHidden = CurrentValueSubject<Bool, Never>(false)
    }
    
    static let statusBar = StatusBar()
}
