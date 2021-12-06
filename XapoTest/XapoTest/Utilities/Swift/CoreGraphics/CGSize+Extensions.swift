// XapoTest
//
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
//


import Foundation
import SwiftUI


extension CGSize {
    
    public init(uniform side: CGFloat) {
        self.init(width: side, height: side)
    }

    public var asRect: CGRect {
        return CGRect(size: self)
    }

    public func centered(in rect: CGRect) -> CGRect {
        var result = asRect
        result.origin.x = (rect.width - width) / 2
        result.origin.y = (rect.height - height) / 2
        return result
    }

    public func centered(in size: CGSize) -> CGRect {
        return centered(in: CGRect(origin: .zero, size: size))
    }

    public var asPixelsForMainScreen: CGSize {
        return self * UIScreen.main.scale
    }

    public var center: CGPoint {
        return CGPoint(x: width / 2, y: height / 2)
    }

    public static var greatestFiniteMagnitude: CGSize {
        return CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    }

    public var area: CGFloat {
        return width * height
    }
    
    public var inverted: CGSize {
        return CGSize(width: height, height: width)
    }
}


public func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
}


extension CGSize: VectorArithmetic {

    public mutating func scale(by rhs: Double) {
        self.width = self.width * CGFloat(rhs)
        self.height = self.height * CGFloat(rhs)
    }
    
    public var magnitudeSquared: Double {
        return Double(sqrt( self.width * self.width + self.height * self.height ))
    }
    
    public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    
    public static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }
}
