// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI


struct RefreshableScrollView<Content: View>: View {
    
    final class ViewModel: ObservableObject {
        
        private(set) var previousScrollOffset: CGFloat = 0
        private(set) var scrollOffset: CGFloat = 0
        
        @Published var frozen: Bool = false
        @Published var rotation: Angle = .degrees(0)
        @Published var opacity: Double = 0
        @Published var progress: Double = 0
        @Published var frozenOffset: CGFloat = 0
        
        @Published var height: CGFloat = 0
        @Published var verticalOffset: CGFloat = 0
        
        
        private var isRefreshing: Bool
        let threshold: CGFloat
        
        private func update(rotation: Angle) {
            guard rotation != self.rotation else { return }
            self.rotation = rotation
        }
        
        private func update(opacity: Double) {
            guard opacity != self.opacity else { return }
            self.opacity = opacity
        }
        
        private func updateProgress(progress: Double) {
            guard progress != self.progress else { return }
            self.progress = progress
        }
        
        private func update(frozen: Bool) {
            guard frozen != self.frozen else { return }
            withAnimation {
                self.frozen = frozen
                frozenOffset = frozen ? scrollOffset : 0
            }
        }
        
        func update(isRefreshing: Bool) {
            guard self.isRefreshing != isRefreshing else { return }
            self.isRefreshing = isRefreshing
            
            let opacity = symbolOpacity(scrollOffset: scrollOffset, threshold: threshold)
            update(opacity: opacity)
            if !isRefreshing {
                update(frozen: false)
            } else {
                Haptic.impact(.heavy).generate()
            }
        }
        
        init(isRefreshing: Bool, thresholdDistance: CGFloat) {
            self.threshold = thresholdDistance
            self.isRefreshing = isRefreshing
        }
        
        func refreshLogic(offset: CGFloat, refreshing: Binding<Bool>) {
            /// Calculate scroll offset
            
            scrollOffset  = offset
            let rotation = symbolRotation(scrollOffset: scrollOffset, threshold: threshold)
            update(rotation: rotation)
            
            let opacity = symbolOpacity(scrollOffset: scrollOffset, threshold: threshold)
            update(opacity: opacity)
            
            let progress = symbolProgress(scrollOffset: scrollOffset, threshold: threshold)
            updateProgress(progress: progress)
            
            /// Crossing the threshold on the way down, we start the refresh process
            if !refreshing.wrappedValue &&
                (scrollOffset > threshold && previousScrollOffset <= threshold) {
                refreshing.wrappedValue = true
                self.update(isRefreshing: true)
            }
            
            if refreshing.wrappedValue {
                /// Crossing the threshold on the way up, we add a space at the top of the scrollview
                if previousScrollOffset > threshold && scrollOffset <= threshold {
                    update(frozen: true)
                }
            } else {
                /// remove the sapce at the top of the scroll view
                update(frozen: false)
            }
            
            /// Update last scroll offset
            previousScrollOffset = scrollOffset
            
            
            let newHeight = max(previousScrollOffset, frozenOffset)
            if height != newHeight { height = newHeight }
            let newVerticalOffset = -(threshold - max(previousScrollOffset.limited(0, threshold), frozenOffset))
            if newVerticalOffset != verticalOffset {
                verticalOffset = newVerticalOffset
            }
        }
        
        private func symbolRotation(scrollOffset: CGFloat, threshold: CGFloat) -> Angle {
            /// We will begin rotation, only after we have passed
            /// 60% of the way of reaching the threshold.
            if scrollOffset < threshold * 0.60 {
                return .degrees(0)
            } else {
                /// Calculate rotation, based on the amount of scroll offset
                let h = Double(threshold)
                let d = Double(scrollOffset)
                let v = max(min(d - (h * 0.6), h * 0.4), 0)
                return .degrees(180 * v / (h * 0.4))
            }
        }
        
        private func symbolOpacity(scrollOffset: CGFloat, threshold: CGFloat) -> Double {
            let start = threshold * 0.5
            
            if isRefreshing || frozen {
                return 0
            }
            
            if scrollOffset < start {
                return 0
            } else {
                let distance = threshold * 0.3
                let progress = ((scrollOffset - start) / distance).limited(0, 1)
                return Double(progress)
            }
        }
        
        private func symbolProgress(scrollOffset: CGFloat, threshold: CGFloat) -> Double {
            let start = threshold * 0.6
            
            if isRefreshing || frozen {
                return 0
            }
            
            let distance = threshold * 0.3
            
            let progress = ((scrollOffset - start) / distance).limited(0, 1)
            return Double(1 - progress)
        }
    }
    
    @StateObject private var viewModel: ViewModel
    
    @State var height: CGFloat = 0
    
    private let axis: Axis.Set
    private let showsIndicators: Bool
    private let threshold: CGFloat
    private let activityColor: Color
    private let content: Content
    
    @Binding var refreshing: Bool
    
    init(refreshing: Binding<Bool>,
         axis: Axis.Set = .vertical,
         showsIndicators: Bool = true,
         thresholdDistance: CGFloat = 100,
         activityColor: Color = Color.gray,
         @ViewBuilder content: () -> Content) {
        
        _viewModel = StateObject(wrappedValue: ViewModel(isRefreshing: refreshing.wrappedValue, thresholdDistance: thresholdDistance))
        _refreshing = refreshing
        self.threshold = thresholdDistance.limited(60, 250)
        self.axis = axis
        self.showsIndicators = showsIndicators
        self.activityColor = activityColor
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { fullViewGeo in
            VStack(spacing: 0) {
                ObservableScrollView(axis: .vertical,
                                     showsIndicators: showsIndicators,
                                     logic: .refreshableOffset(onChangeOffset: { newOffset in
                    viewModel.refreshLogic(offset: -newOffset, refreshing: $refreshing) })
                ) { _ in
                    
                    ZStack(alignment: .top) {
                        
                        VStack(spacing: 0) {
                            
                            self.placeholder
                            
                            self.content
                        }
                        
                        HStack(spacing: 0) {
                            Spacer(minLength: 0)
                            GeometryReader { geo in
                                let height = refreshing ? threshold : (geo.frame(in: .global).minY - fullViewGeo.frame(in: .global).minY).limited(0, threshold)
                                VStack(spacing: 0) {
                                    XapoLogoIndicatorView(rotation: viewModel.rotation, tintColor: activityColor, progress: viewModel.progress)
                                        .offset(y: -threshold)
                                        .opacity(viewModel.opacity)
                                    Spacer(minLength: 0)
                                }
                                .frame(width: geo.size.width , height: height )
                            }
                            .frame(height: 0)
                        }
                        
                        XapoTopLoadingIndicator(refreshing: $refreshing)
                            .frame(size: CGSize(uniform: 100))
                            .opacity(refreshing ? 1 : 0)
                            .offset(y: -20)
                    }
                }
                .onChange(of: refreshing, perform: { value in
                    self.viewModel.update(isRefreshing: value)
                })
            }
        }
    }
    
    private var placeholder: some View {
        VStack(spacing: 0) {
            Color.clear
        }
        .frame(height:  withAnimation {refreshing ? threshold * 0.5 : 0 })
    }
}


//MARK: - Subviews
extension RefreshableScrollView {
    
    struct XapoTopLoadingIndicator: View {
        
        @Binding var refreshing: Bool
        @State private var fireAnimation: Bool = false
        @State private var rotationAnimation: Bool = false
        
        var body: some View {
            ZStack {
                XapoLogoShape(mode: .pulsar,
                              initialState: .circle,
                              animated: $fireAnimation,
                              shapeHeight: 50)
                    .rotationEffect(Angle(degrees: fireAnimation ? 360 : 0.0))
                    .animation(Animation.linear(duration: 1.0).do(while: fireAnimation, autoreverses: false))
            }
            .onChange(of: $refreshing.wrappedValue, perform: { value in
                fireAnimation = value
            })
            .onAppear { rotationAnimation = true }
        }
    }
    
    struct XapoLogoIndicatorView: View {
        let rotation: Angle
        let tintColor: Color
        let progress: CGFloat
        
        var body: some View {
            VStack(spacing: 0) {
                Spacer(minLength: 0)
                XapoLogoShape(mode: .immobile,
                              initialState: .expanded,
                              animated: .constant(false),
                              shapeHeight: 50,
                              progress: progress,
                              duration: 0,
                              delay: 0)
                    .rotationEffect(rotation)
                    .padding(.bottom, 15)
            }
        }
    }
}
