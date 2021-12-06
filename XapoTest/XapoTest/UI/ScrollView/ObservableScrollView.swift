// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import SwiftUI


struct ObservableScrollView<Content>: View where Content: View {
    
    enum Logic {
        /// use default combined with a binding
        case `default`
        /// use when you need to redraw only when rfresh event
        case refreshableOffset(onChangeOffset: (CGFloat) -> Void)
    }
    
    private let currentLogic: Logic
    
    @Binding private  var contentOffset: CGFloat
    
    private let axis: Axis.Set
    private let showsIndicators: Bool
    private let content: (ScrollViewProxy) -> Content
    
    @inlinable init(axis: Axis.Set = .vertical,
                    showsIndicators: Bool = true,
                    logic: Logic = .default,
                    contentOffset: Binding<CGFloat> = .constant(0),
                    ///TODO: add `onRefresh: ((_ completion: @escaping () -> Void) -> Void)? = nil,` for native SwiftUI scroll view
                    @ViewBuilder content: @escaping (ScrollViewProxy) -> Content) {
        
        _contentOffset = contentOffset
        self.currentLogic = logic
        self.axis = axis
        self.showsIndicators = showsIndicators
        self.content = content
    }
    
    var body: some View {
        GeometryReader { outsideProxy in
            ScrollViewReader { scrollProxy in
                ScrollView(axis, showsIndicators: showsIndicators) {
                    ZStack(alignment: axis == .vertical ? .top : .leading) {
                        GeometryReader { insideProxy in
                            let offset = self.calculateContentOffset(fromOutsideProxy: outsideProxy, insideProxy: insideProxy)
                            Color.clear
                                .preference(key: ScrollOffsetPreferenceKey.self, value: [offset])
                        }
                        self.content(scrollProxy)
                    }
                }
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { values in
                    if let value = values.at(0) {
                        switch currentLogic {
                            case .default:
                                self.contentOffset = value
                            case .refreshableOffset(let onChangeOffset):
                                guard value <= 0.0 else { return }
                                onChangeOffset(value)
                        }
                    }
                }
            }
        }
    }
    
    private func calculateContentOffset(fromOutsideProxy outsideProxy: GeometryProxy, insideProxy: GeometryProxy) -> CGFloat {
        if axis == .vertical {
            return outsideProxy.frame(in: .global).minY - insideProxy.frame(in: .global).minY
        } else {
            return outsideProxy.frame(in: .global).minX - insideProxy.frame(in: .global).minX
        }
    }
}


struct ScrollOffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue: [CGFloat] = [0]
    
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}
