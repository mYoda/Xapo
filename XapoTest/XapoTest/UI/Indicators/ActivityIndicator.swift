// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    private let shouldAnimate: Binding<Bool>
    private let style: UIActivityIndicatorView.Style
    private let color: UIColor
    
    init(shouldAnimate: Binding<Bool> = .constant(true),
         style: UIActivityIndicatorView.Style = .medium,
         color: UIColor = .gray) {
        
        self.shouldAnimate = shouldAnimate
        self.style = style
        self.color = color
    }
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: style)
        view.color = color
        return view
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.shouldAnimate.wrappedValue {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

