// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI


struct LoadingOverlay: View {
    
    @State private var isAnimating: Bool = false
        
    var body: some View {
        return ZStack {
            Color.black.opacity(0.35).edgesIgnoringSafeArea(.all)
            
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .frame(width: 150, height: 150)
            
            ActivityIndicator(shouldAnimate: $isAnimating,
                              style: UIActivityIndicatorView.Style.large,
                              color: UIColor.gray)
        }
        .onAppear { isAnimating = true }
        .edgesIgnoringSafeArea(.all)
    }
}

