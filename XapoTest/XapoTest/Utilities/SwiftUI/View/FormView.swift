// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI


private let defaultShadowColor = Color.black.opacity(0.04)
private let defaultShadowRadius: CGFloat = 8


extension View {
    
    var asFormBlock: some View {
        asFormBlock()
    }
    
    func asFormBlock(fillColor: Color = Color.white,
                     cornerRadius: CGFloat = CGFloat.cornerRadius,
                     shadowColor: Color = defaultShadowColor,
                     shadowRadius: CGFloat = defaultShadowRadius) -> some View {
        
        background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(fillColor)
                .shadow(color: shadowColor, radius: shadowRadius)
        )
    }
}
