// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI


final class WelcomeViewModel: ObservableObject {
    
    @Published var animationFinished: Bool = true
        
    func animate() {
        
        self.animationFinished = true
        
    }
}
