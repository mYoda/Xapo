// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI


public struct OpacityTapEffect: ViewModifier {

    @State private var opacity: Double = 1
    
    private let opacityEffect: Double
    private let animation: Animation
    private let onTap: (() -> Void)?
    
    init(opacityEffect: Double,
         animation: Animation = .default,
         onTap: (() -> Void)? = nil) {
        
        self.opacityEffect = opacityEffect
        self.animation = animation
        self.onTap = onTap
    }
    
    public func body(content: Content) -> some View {
        return content
            .opacity(opacity)
            .onTapGesture {
                opacity = opacityEffect
                withAnimation(animation) { opacity = 1 }
                onTap?()
            }
    }
}

public struct ScaleTapEffect: ViewModifier {

    @State private var scale: CGFloat = 1
    
    private let scaleEffect: CGFloat
    private let inAnimation: Animation
    private let outAnimation: Animation
    private let onTap: (() -> Void)?
    
    init(scaleEffect: CGFloat,
         inAnimation: Animation = .easeIn(duration: 0.25),
         outAnimation: Animation = .easeOut(duration: 0.25),
         onTap: (() -> Void)? = nil) {
        
        self.scaleEffect = scaleEffect
        self.inAnimation = inAnimation
        self.outAnimation = outAnimation
        self.onTap = onTap
    }
    
    public func body(content: Content) -> some View {
        return content
            .scaleEffect(scale)
            .onTapGesture {
                withAnimation(inAnimation) { scale = scaleEffect }
                withAnimation(outAnimation) { scale = 1 }
                onTap?()
            }
    }
}

public extension View {
    func opacityTap(opacityEffect: Double = 0.95,
                    animation: Animation = .default,
                    onTap: (() -> Void)? = nil) -> some View {
        
        modifier(OpacityTapEffect(opacityEffect: opacityEffect, animation: animation, onTap: onTap))
    }
    
    func scaleTap(scaleEffect: CGFloat = 1.01,
                  inAnimation: Animation = .easeIn(duration: 0.25),
                  outAnimation: Animation = .easeOut(duration: 0.25),
                  onTap: (() -> Void)? = nil) -> some View {
        
        modifier(ScaleTapEffect(scaleEffect: scaleEffect,
                                inAnimation: inAnimation,
                                outAnimation: outAnimation,
                                onTap: onTap))
    }
}

