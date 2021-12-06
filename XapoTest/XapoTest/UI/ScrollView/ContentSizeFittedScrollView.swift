// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
//


import Foundation
import SwiftUI


///  ScrollView that fits content's size or given `maxSize`
struct ContentSizeFittedScrollView<Content: View>: View {
    
    @State private var currentSize: CGSize = .zero
    
    private let axes: Axis.Set
    private let showsIndicators: Bool
    private let content: Content
    private let minHeight: CGFloat
    private let maxHeight: CGFloat
    private let minWidth: CGFloat
    private let maxWidth: CGFloat
    private let backgroundColor: Color
    /**
         - Parameters:
            - showsIndicators: A Boolean value that indicates whether the scroll view displays the scrollable component of the content offset, in a way suitable for the platform. The default value for this parameter is true.
            - axes: The scroll view’s scrollable axis. The default axis is the vertical axis.
            - minWidth: The minimum width of scrollable content (actual for `.horizontal` axes only).
                `default`: 0
            - maxWidth: The maximum width of scrollable content (actual for `.horizontal` axes only).
                `default`: .infinity
            - minHeight: The minimum height of scrollable content (actual for `.vertical` axes only).
                `default`: 0
            - maxHeight: The maximum height of scrollable content (actual for `.vertical` axes only).
                `default`: .infinity
            - backgroundColor: The color of the View. `default`: .clear
            - content: The view builder that creates the scrollable view.

         */
    init(showsIndicators: Bool = false,
         axes: Axis.Set = .vertical,
         minWidth: CGFloat = 0,
         maxWidth: CGFloat = .infinity,
         minHeight: CGFloat = 0,
         maxHeight: CGFloat = .infinity,
         backgroundColor: Color = .clear,
         @ViewBuilder content: () -> Content) {
        
        self.showsIndicators = showsIndicators
        self.content = content()
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.backgroundColor = backgroundColor
        self.axes = axes
        self.minWidth = minWidth
        self.maxWidth = maxWidth
    }
    
    var body: some View {
        ScrollView(showsIndicators: showsIndicators) {
            ZStack(alignment: axes == .vertical ? .top : .leading) {
                
                GeometryReader { geo in
                    Color.clear.onAppear {
                        currentSize = geo.size
                    }
                }
                
                self.content
            }
        }
        .apply(axes == .horizontal, apply: {
            $0.frame(width: currentSize.width.limited(minWidth, maxWidth))
                .frame(minHeight: minHeight)
            
        }, otherwise: {
            $0.frame(height: currentSize.height.limited(minHeight, maxHeight))
                .frame(minWidth: minWidth)
            
        })
        .background(backgroundColor)
    }
}
