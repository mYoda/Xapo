// XapoTest
//    
// Created by Anton Nechayuk © 
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI


public struct PopupView: View {
        
    private let popup: PopupModel
    private let onHide: (PopupModel) -> Void
    @State private var animateBackground: Bool = false
    
    init(popup: PopupModel, onHide: @escaping (PopupModel) -> Void) {
        self.popup = popup
        self.onHide = onHide
    }
        
    public var body: some View {
        ZStack {
            if animateBackground {
                background
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
            }
            
            Color.clear
                .contentShape(Rectangle())
                .edgesIgnoringSafeArea(.all)
                .popup(isPresented: nil, model: popup, willHide: willHide, onHide: onHide)
        }
        .onAppear {
            withAnimation { animateBackground = true }
        }
    }
    
    private var background: some View {
        switch popup.background {
        case .clear: return Color.clear
        case .dark: return Color.black.opacity(0.7)
        case .color(let color): return color
        }
    }
    
    private func willHide(animationTime: TimeInterval) {
        withAnimation(.easeOut(duration: animationTime)) { animateBackground = false }
    }
}


public enum PopupType {

    public enum Position {
        case top
        case bottom
    }
    
    case `default`
    case toast(position: Position = .top)
    case floater(position: Position = .top, verticalPadding: CGFloat = 50)

    var isCentered: Bool {
        if case .`default` = self { return true }
        return false
    }
    
    var topAppearance: Bool {
        switch self {
        case .floater(let position, _) where position == .top:
            return true
        case .toast(let position) where position == .top:
            return true
        default:
            return false
        }
    }
    
    var bottomAppearance: Bool {
        return !topAppearance
    }
}


public struct Popup: ViewModifier {
    
    @State private var dragGestureStorage: [DragGesture.Value] = []
    @State private var isPresented: Bool = false
    /// If `externalPresentation` not nil it will controls popup visibility, otherwise `isPresented` state will be used
    private let externalPresentation: Binding<Bool>?
    
    @State private var draggingOffset: CGFloat = 0
    
    let popup: PopupModel
    let willHide: (TimeInterval) -> Void
    let onHide: (PopupModel) -> Void
    
    init(isPresented: Binding<Bool>? = nil,
         popup: PopupModel,
         willHide: @escaping (TimeInterval) -> Void = { _ in },
         onHide: @escaping (PopupModel) -> Void) {
        
        self.externalPresentation = isPresented
        self.popup = popup
        self.willHide = willHide
        self.onHide = onHide
    }
    
    private func hide(animated: Bool = true) {
        guard isPresented else { return }
        if animated {
            let animationTime: TimeInterval = 0.5
            willHide(animationTime)
            
            withAnimation(popup.animation) {
                self.externalPresentation?.wrappedValue = false
                self.isPresented = false
            }
            //After animation is done, remove popup from rendering
            delay(animationTime + 0.1) { self.onHide(self.popup) }
        } else {
            self.externalPresentation?.wrappedValue = false
            self.isPresented = false
            delay(0.1) { self.onHide(self.popup) }
        }
        
    }
    
    /// holder for autohiding dispatch work (to be able to cancel it when needed)
    private let dispatchWorkHolder = DispatchWorkHolder()

    // MARK: - Private Properties

    /// The rect of the hosting controller
    @State private var presenterContentRect: CGRect = .zero

    /// The rect of popup content
    @State private var sheetContentRect: CGRect = .zero

    /// The current offset, based on the **presented** property
    private var currentOffset: CGFloat {
        let presented = externalPresentation?.wrappedValue ?? isPresented
        let offset = presented ? displayedOffset + draggingOffset : hiddenOffset
        return offset
    }
    
    private var currentOpacity: Double {
        guard popup.transition == .opacity else { return 1.0 }
        let presented = externalPresentation?.wrappedValue ?? isPresented
        return presented ? 1 : 0
    }

    // MARK: - Content Builders

    public func body(content: Content) -> some View {
        content
            .applyIf(popup.closeOnTapOutside) {
                $0.simultaneousGesture(TapGesture().onEnded { self.hide() })
            }
            .background(
                GeometryReader { proxy -> AnyView in
                    let rect = proxy.frame(in: .global)
                    // This avoids an infinite layout loop
                    if rect.integral != self.presenterContentRect.integral {
                        DispatchQueue.main.async {
                            self.presenterContentRect = rect
                        }
                    }
                    return AnyView(EmptyView())
                }
            )
            .overlay(sheet())
            .onAppear() {
                if self.externalPresentation == nil {
                    //Warning: without delay animation will be default.
                    delay(0.1) { self.isPresented = true }
                }
            }
            //.onReceive(DeviceInfo.splitModeDidChanged, perform: { self.hide(animated: false) })
    }

    /// This is the builder for the sheet content
    func sheet() -> some View {

        // if needed, dispatch autohide and cancel previous one
        if let autohideIn = popup.autohideIn {
            dispatchWorkHolder.work?.cancel()
            dispatchWorkHolder.work = DispatchWorkItem(block: { self.hide() })
            
            let presented = externalPresentation?.wrappedValue ?? isPresented
            if presented, let work = dispatchWorkHolder.work {
                DispatchQueue.main.asyncAfter(deadline: .now() + autohideIn, execute: work)
            }
        }

        return ZStack {
            Group {
                VStack {
                    VStack {
                        self.popup.content( { hide() } )
                            .applyIf(self.popup.closeOnTap) {
                                $0.simultaneousGesture(TapGesture().onEnded {
                                    self.hide()
                                })
                            }
                            .background(
                                GeometryReader { proxy -> AnyView in
                                    let rect = proxy.frame(in: .global)
                                    // This avoids an infinite layout loop
                                    if rect.integral != self.sheetContentRect.integral {
                                        DispatchQueue.main.async {
                                            self.sheetContentRect = rect
                                        }
                                    }
                                    return AnyView(EmptyView())
                                }
                            )
                    }
                }
                .offset(x: 0, y: currentOffset)
                .opacity(currentOpacity)
                .simultaneousGesture(DragGesture()
                    .onChanged({ value in
                        
                        dragGestureStorage.append(value)
                        guard dragGestureStorage.count > 4 else { return }
                        
                        let offset = Math.dampen(value.translation.height,
                                                 range: draggingBound,
                                                 spring: popup.springOffset)
                        self.draggingOffset = offset
                    })
                    .onEnded({value in
                        if shouldClose(draggingOffset: draggingOffset) {
                            self.hide()
                        } else {
                            self.draggingOffset = 0
                        }
                        self.dragGestureStorage.removeAll()
                    })
                )
                .animation(popup.animation)
            }
        }
    }
    
    private var draggingBound: ClosedRange<CGFloat> {
        guard popup.closeOnDrag else { return 0...0 }
        if popup.type.topAppearance {
            return -sheetContentRect.height...0
        } else {
            return 0...sheetContentRect.height
        }
    }
    
    private func shouldClose(draggingOffset: CGFloat) -> Bool {
        guard popup.closeOnDrag else { return false }
        switch popup.type {
        case .default:
            return draggingOffset > 250
        default:
            if popup.type.bottomAppearance {
                return draggingOffset > (sheetContentRect.height / 2)
            } else {
                return -draggingOffset > (sheetContentRect.height / 2)
            }
        }
    }
}


//MARK: - Helpers
final class DispatchWorkHolder {
    var work: DispatchWorkItem?
}


//MARK: - Offsets calculation
extension Popup {
    
    /// The offset when the popup is displayed
    private var displayedOffset: CGFloat {
        switch popup.type {
        case .`default`:
            return  -presenterContentRect.midY + screenHeight/2
        case .toast(let position):
            switch position {
            case .bottom:
                return screenHeight - presenterContentRect.midY - sheetContentRect.height/2
            case .top:
                return -presenterContentRect.midY + sheetContentRect.height/2
            }
        case let .floater(position, padding):
            switch position {
            case .bottom:
                return screenHeight - presenterContentRect.midY - sheetContentRect.height/2 - padding
            case .top:
                return -presenterContentRect.midY + sheetContentRect.height/2 + padding
            }
        }
    }

    /// The offset when the popup is hidden
    private var hiddenOffset: CGFloat {
        guard popup.transition == .slide else { return 0 }
        
        if popup.type.topAppearance {
            guard !presenterContentRect.isEmpty else { return -1000 }
            return -presenterContentRect.midY - sheetContentRect.height/2 - 5
        } else {
            guard !presenterContentRect.isEmpty else { return 1000 }
            return screenHeight - presenterContentRect.midY + sheetContentRect.height/2 + 5
        }
    }

    private var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
}
