import Foundation
import SwiftUI


extension View {
    
    @inlinable
    public func offsetIf(_ condition: Bool, _ point: CGPoint) -> some View {
        offset(condition ? point : .zero)
    }
    
    public func applyIf<T: View>(_ condition: @autoclosure () -> Bool, apply: (Self) -> T) -> AnyView {
        if condition() {
            return AnyView(apply(self))
        } else {
            return AnyView(self)
        }
    }
    
    public func apply<T: View, K: View>(_ condition: @autoclosure () -> Bool,
                                 apply: (Self) -> T,
                                 otherwise: (Self) -> K) -> AnyView {
        if condition() {
            return AnyView(apply(self))
        } else {
            return AnyView(otherwise(self))
        }
    }
    
    public func applyIfExist<T: View, V>(_ condition: @autoclosure () -> V?, apply: (Self, V) -> T) -> AnyView {
        if let v = condition() {
            return AnyView(apply(self, v))
        } else {
            return AnyView(self)
        }
    }
}


extension View {
    // If condition is met, apply modifier, otherwise, leave the view untouched
    public func conditionalModifier<T>(_ condition: Bool, _ modifier: T) -> some View where T: ViewModifier {
        Group {
            if condition {
                self.modifier(modifier)
            } else {
                self
            }
        }
    }

    // Apply trueModifier if condition is met, or falseModifier if not.
    public func conditionalModifier<M1, M2>(_ condition: Bool, _ trueModifier: M1, _ falseModifier: M2) -> some View where M1: ViewModifier, M2: ViewModifier {
        Group {
            if condition {
                self.modifier(trueModifier)
            } else {
                self.modifier(falseModifier)
            }
        }
    }
}
