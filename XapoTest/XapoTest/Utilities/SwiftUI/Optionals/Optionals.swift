// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI


struct OptionalDetails<T,V: View>: View {
    
    let data: T?
    let content: (T) -> V
    
    var body: some View {
        ZStack {
            if let d = data {
                content(d)
            } else {
                EmptyView()
            }
        }
    }
}


protocol OptionalType {
    var isExist: Bool { get }
    mutating func erase()
}


extension Optional: OptionalType {
    var isExist: Bool {
        switch self {
        case .some: return true
        case .none: return false
        }
    }
    
    var isNotExist: Bool {
        return !isExist
    }
    
    mutating func erase() {
        self = .none
    }
}

extension Binding where Value: OptionalType {

    var isPresented: Binding<Bool> {
        return Binding<Bool>(get: { return self.wrappedValue.isExist },
                             set: { new in if !new { self.wrappedValue.erase() } })
    }
}
