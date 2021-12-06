// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI


struct XapoLoadingOverlay: View {
    
    @State private var isAnimating: Bool = false
        
    var body: some View {
        return ZStack {
            Color.black.opacity(0.35).edgesIgnoringSafeArea(.all)
            
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .frame(width: 150, height: 150)
            
            XapoLogoShape(mode: .pulsar, initialState: .circle, animated: $isAnimating, shapeHeight: 70)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0.0))
                .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false), value: isAnimating)
        }
        .onAppear { isAnimating = true }
        .edgesIgnoringSafeArea(.all)
    }
}
