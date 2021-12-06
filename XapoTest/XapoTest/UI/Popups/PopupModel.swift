// XapoTest
//    
// Created by Anton Nechayuk © 
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI

/**
Model a popup to be displayed
*/
public struct PopupModel: Equatable {
    
    public static func == (lhs: PopupModel, rhs: PopupModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum BackgroundType {
        case clear
        case dark
        case color(Color)
    }
    
    enum TransitionType {
        case slide
        case opacity
    }
    
    let id: UUID
    let content: (_ hideAction: @escaping () -> Void) -> AnyView
    
    let type: PopupType
    
    let animation: Animation
    
    let transition: TransitionType
    
    /// If nil - popup will not hide automatically after delay
    let autohideIn: TimeInterval?
    
    /// Offset for user drag from locked position - default is `0`
    let springOffset: CGFloat

    /// Could be closed by dragging - default is `true`
    let closeOnDrag: Bool
    
    /// Should close on tap - default is `false`
    let closeOnTap: Bool

    /// Should close on tap outside - default is `true`
    let closeOnTapOutside: Bool
    
    /// Popup background view type
    let background: BackgroundType
    
    
    /// Callback will call when popup has been closed
    let onClose: (() -> Void)?
    
    /**
    - parameters:
        - content: The closure will be called with the id of the popup
    */
    init<Content: View>(
        type: PopupType = .`default`,
        background: BackgroundType = .clear,
        animation: Animation = Popup.defaultSpringAnimation,
        transition: TransitionType = .slide,
        autohideIn: TimeInterval? = nil,
        springOffset: CGFloat = 0,
        closeOnDrag: Bool = true,
        closeOnTap: Bool = false,
        closeOnTapOutside: Bool = true,
        onClose: (() -> Void)? = nil,
        @ViewBuilder content: @escaping (_ id: UUID, _ hideAction: @escaping () -> Void) -> Content) {
        
        let id = UUID()
        self.id = id
        self.content = { hideAction in AnyView(content(id, hideAction)) }
        self.type = type
        self.background = background
        self.animation = animation
        self.transition = transition
        self.autohideIn = autohideIn
        self.springOffset = springOffset
        self.closeOnDrag = closeOnDrag
        self.closeOnTap = closeOnTap
        self.onClose = onClose
        self.closeOnTapOutside = closeOnTapOutside
    }
}
