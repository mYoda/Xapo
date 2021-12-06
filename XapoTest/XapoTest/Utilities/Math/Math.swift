// XapoTest
//    
// Created by Anton Nechayuk © 
// with 🧡 for Xapo in 2021
// 


import Foundation
import UIKit


public enum Math {
    
    public static func lerp<T: FloatingPoint>(from: T, to: T, progress: T) -> T {
        return from + progress * (to - from)
    }
        
    public static func lerp(from: CGRect, to: CGRect, progress: CGFloat) -> CGRect {
        let x = lerp(from: from.origin.x, to: to.origin.x, progress: progress)
        let y = lerp(from: from.origin.y, to: to.origin.y, progress: progress)
        let w = lerp(from: from.size.width, to: to.size.width, progress: progress)
        let h = lerp(from: from.size.height, to: to.size.height, progress: progress)
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    public static func interpolate<T: FloatingPoint>(values: [(position: T, value: T)], position: T) -> T {
        
        let sorted = values.sorted { (p1, p2) -> Bool in p1.position < p2.position }
        
        let prev = sorted.last(where: { $0.position <= position })
        let next = sorted.first(where: { $0.position > position })
        
        if let a = prev, let b = next {
            let n = (position - a.position) / (b.position - a.position)
            return a.value + (b.value - a.value) * n
        } else if let a = prev ?? next {
            return a.value
        } else {
            return 0
        }
    }
    
    public static func nomalizeProgress(min: CGFloat, max: CGFloat, progress: CGFloat) -> CGFloat {
        let p = progress.limited(min, max)
        let current = (p - min)
        return current / (max - min)
    }
    
    public static func mirrorProgress(_ progress: CGFloat) -> CGFloat {
        let p = progress.limited(0, 1)
        return (p < 0.5) ? p * 2 : 1 - (p - 0.5) * 2
    }
    
    public static func dampen(_ value: CGFloat, range: ClosedRange<CGFloat>, spring: CGFloat) -> CGFloat {
        if range.contains(value) {
            return value
        } else if value > range.upperBound {
            let change = value - range.upperBound
            let x = pow(M_E, Double(change) / Double(spring))
            return -(2 * spring) / CGFloat(1 + x) + spring + range.upperBound
        } else {
            let change = value - range.lowerBound
            let x = pow(M_E, Double(change) / Double(spring))
            return -(2 * spring) / CGFloat(1 + x) + spring + range.lowerBound
        }
    }
}


public enum Progress {
    
    public static func nomalizeProgress<T: FloatingPoint>(min: T, max: T, progress: T) -> T {
        let p = progress.limited(min, max)
        let current = (p - min)
        return current / (max - min)
    }
    
    public static func centeredRangeProgress<T: FloatingPoint>(progress: T, centerRange: T) -> T {

        let normalProgress = progress.limited(0, 1)

        let p1 = (1 - centerRange) / 2
        let p2 = (1 + centerRange) / 2
        let rangeProgress: T
        switch progress {
        case let x where x < p1:
            rangeProgress = normalProgress / p1
        case let x where x <= p2:
            rangeProgress = 1
        case let x where x > p2:
            rangeProgress = 1 - (normalProgress - p2) / p1
        default:
            rangeProgress = 0
        }
        return rangeProgress
    }
}

public enum Inertia {

    public static func applyResistance(for source: CGFloat, with scrollPosition: CGFloat, decelerationRate: UIScrollView.DecelerationRate = .fast, maximumScrollDistance: CGFloat = 120) -> CGFloat {
        let resistantDistance = (decelerationRate.rawValue * abs(scrollPosition) * maximumScrollDistance) / (maximumScrollDistance + decelerationRate.rawValue * abs(scrollPosition))
        return source + (scrollPosition < 0 ? -resistantDistance : resistantDistance)
    }

    // Distance travelled after deceleration to zero velocity at a constant rate
    public static func project(initialVelocity: CGFloat, decelerationRate: UIScrollView.DecelerationRate = .fast) -> CGFloat {
        return (initialVelocity / 1000.0) * decelerationRate.rawValue / (1.0 - decelerationRate.rawValue)
    }
}

