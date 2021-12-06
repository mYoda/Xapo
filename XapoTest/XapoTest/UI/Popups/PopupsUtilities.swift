// XapoTest
//    
// Created by Anton Nechayuk © 
// with 🧡 for Xapo in 2021
// 


import SwiftUI

extension Popup {
    public static let defaultSpringAnimation = Animation.interpolatingSpring(stiffness: 130, damping: 15)
    public static let defaultEaseAnimation = Animation.easeOut(duration: 0.3)
    public static let defaultLinearAnimation = Animation.linear(duration: 0.3)
}

extension View {

    public func popup<Content: View>(
        isPresented: Binding<Bool>,
        type: PopupType = .`default`,
        animation: Animation = Popup.defaultEaseAnimation,
        autohideIn: Double? = nil,
        closeOnTap: Bool = true,
        closeOnTapOutside: Bool = false,
        onHide: @escaping (PopupModel) -> Void = { _ in },
        @ViewBuilder content: @escaping (_ id: UUID, _ hideAction: () -> Void) -> Content) -> some View {
        
        let model = PopupModel(
            type: type,
            animation: animation,
            autohideIn: autohideIn,
            closeOnTap: closeOnTap,
            closeOnTapOutside: closeOnTapOutside,
            content: content
        )
        
        return self.modifier(
            Popup(isPresented: isPresented,
                  popup: model,
                  onHide: onHide)
        )
    }
    
    public func popup(isPresented: Binding<Bool>? = nil,
                      model: PopupModel,
                      willHide: @escaping (TimeInterval) -> Void = { _ in },
                      onHide: @escaping (PopupModel) -> Void) -> some View {
        
        return self.modifier(
            Popup(isPresented: isPresented, popup: model, willHide: willHide, onHide: onHide)
        )
    }
}
