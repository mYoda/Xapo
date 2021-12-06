// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI

struct XapoLogoShape: View {
    
    enum AnimationMode: Equatable {
        case pulsar
        case immobile
        case repeatCount(Int)
        
        var repeatCount: Int? {
            switch self {
                case .repeatCount(let count): return count
                default: return nil
            }
        }
    }
    
    enum InitialState {
        case expanded
        case circle
    }
    
    @Binding var animated: Bool
    
    private let animationMode: AnimationMode
    private let initialState: InitialState
    private let shapeHeight: CGFloat
    private let progress: CGFloat
    private let duration: CGFloat
    private let delay: CGFloat
    
    init(mode: AnimationMode = .pulsar,
         initialState: InitialState = .circle,
         animated: Binding<Bool>,
         shapeHeight: CGFloat,
         progress: CGFloat = 1.0,
         duration: CGFloat = 1.0,
         delay: CGFloat = 0.3) {
        
        self.animationMode = mode
        self.initialState = initialState
        self._animated = animated
        let height = sqrt(2) * shapeHeight.limited(2, .infinity)
        self.shapeHeight = height
        self.progress = progress
        self.duration = duration
        self.delay = delay
    }
    
    var body: some View {
        
        ZStack (alignment: .center) {
            AnimatedShape(animated: animated,
                          shapeHeight: shapeHeight,
                          initialState: initialState,
                          animationMode: animationMode,
                          progress: progress,
                          duration: duration,
                          delay: delay)
                .rotationEffect(.degrees(-90))
                .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
            
            AnimatedShape(animated: animated,
                          shapeHeight: shapeHeight,
                          initialState: initialState,
                          animationMode: animationMode,
                          progress: progress,
                          duration: duration,
                          delay: delay)
        }
        .rotationEffect(.degrees(45))
    }
}

extension XapoLogoShape {
    
    struct AnimatedShape: View {
        
        
        private let animationMode: AnimationMode
        private let initialState: InitialState
        
        private let fireAnimation: Bool
        private let shapeHeight: CGFloat
        private let p: CGFloat
        
        private let duration: CGFloat
        private let delay: CGFloat
        
        private var w: CGFloat { shapeHeight / 3 }
        private var h: CGFloat { shapeHeight - (2 * r) }
        private var r: CGFloat { w / 2 }
        private var l: CGFloat { shapeHeight / 12 }
        
        private var x1: CGFloat { l / 2 }
        private var x2: CGFloat { w / 2 }
        private var x3: CGFloat { w - (l / 2) }
        
        private var y0: CGFloat { r + h / 2 }
        
        private var y1: CGFloat {
            let d = ((r + (h / 2) - l) - y0)
            return d * p + y0
        }
        private var y2: CGFloat {
            let d = ((r + h) - y0)
            return d * p + y0
        }
        private var y3: CGFloat {
            let d = ((r + (h / 2) + l) - y0)
            return d * p + y0
        }
        private var y4: CGFloat {
            let d = (r - y0)
            return d * p + y0
        }
        
        // adding "sticker" to hide a bug (line-break) at the beginning of the animation
        private var line1: [CGFloat] { [ (y3 + sticker), y4, y4, (y1 + sticker)] }
        private var line2: [CGFloat] { [y0, y0, y0, y0] }
        private var line3: [CGFloat] { [y1, y2, y2, y3] }
        
        private var sticker: CGFloat { p > 0.1 ? l / 2 : 0 }
        
        init(animated: Bool,
             shapeHeight: CGFloat,
             initialState: InitialState = .circle,
             animationMode: AnimationMode = .immobile,
             progress: CGFloat = 1,
             duration: CGFloat,
             delay: CGFloat) {
            
            self.p = progress.limited(0, 1)
            self.shapeHeight = shapeHeight - (shapeHeight / 12) * 1.5
            self.initialState = initialState
            self.animationMode = animationMode
            self.fireAnimation = animated
            self.duration = duration
            self.delay = delay
        }
        
        
        var body: some View {
            ZStack (alignment: .center) {
                LineShape(shapeType: .opposite, yValues: getYValues(for: .opposite), r: r, l: l, x1: x1, x2: x2, x3: x3)
                    .foregroundColor(Color.red)
                
                LineShape(shapeType: .normal, yValues: getYValues(for: .normal), r: r, l: l, x1: x1, x2: x2, x3: x3)
                    .foregroundColor(Color.orange)
                
            }
            .frame(width: w, height: h + 2 * r, alignment: .center)
            .apply( animationMode.repeatCount.isNotExist ,
                    apply: { $0.animation(.easeOut(duration: duration)
                                            .delay(delay).do(while: fireAnimation)) },
                    otherwise: { $0.animation(.easeOut(duration: duration)
                                                .delay(delay)
                                                .repeatCount(animationMode.repeatCount ?? 1, autoreverses: true))
            })
        }
        
        
        private func getYValues(for shapeType: LineShape.ShapeType) -> [CGFloat] {
            switch shapeType {
                case .normal:
                    switch animationMode {
                        case .pulsar, .repeatCount:
                            if initialState == .circle {
                                return fireAnimation ? line3 : line2
                            } else {
                                return fireAnimation ? line2 : line3
                            }
                        case .immobile:
                            if initialState == .circle {
                                return line2
                            } else {
                                return line3
                            }
                    }
                    
                case .opposite:
                    switch animationMode {
                        case .pulsar, .repeatCount:
                            if initialState == .circle {
                                return fireAnimation ? line1 : line2
                            } else {
                                return fireAnimation ? line2 : line1
                            }
                        case .immobile:
                            if initialState == .circle {
                                return line2
                            } else {
                                return line1
                            }
                    }
            }
        }
    }
    
    struct LineShape: Shape {
        
        enum ShapeType {
            case normal
            case opposite
        }
        
        static var storedNormalPath = Path()
        static var storedOppositePath = Path()
        
        var shapeType: ShapeType
        
        var yValues: [CGFloat]
        
        let r: CGFloat
        let l: CGFloat
        
        let x1: CGFloat
        let x2: CGFloat
        let x3: CGFloat
        
        var animatableData: AnimatableLine {
            get { AnimatableLine(values: yValues.map { Double($0) }) }
            set { yValues = newValue.values.map { CGFloat($0) } }
        }
        
        func path(in rect: CGRect) -> Path {
            self.generatePath()
        }
        
        private func generatePath() -> Path {
            
            guard let y0 = yValues.at(0),
                  let y1 = yValues.at(1),
                  let y2 = yValues.at(2),
                  let y3 = yValues.at(3) else { return storedPath() }
            
            var path = Path()
            
            switch shapeType {
                case .normal:
                    path.move(to: CGPoint(x: x1, y: y0))
                    path.addLine(to: CGPoint(x: x1, y: y1))
                    path.addArc(center: CGPoint(x: x2, y: y2), radius: r - (l / 2), startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 0), clockwise: true)
                    path.addLine(to: CGPoint(x: x3, y: y3))
                case .opposite:
                    path.move(to: CGPoint(x: x3, y: y0))
                    path.addLine(to: CGPoint(x: x3, y: y1))
                    path.addArc(center: CGPoint(x: x2, y: y2), radius: r - (l / 2), startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: true)
                    path.addLine(to: CGPoint(x: x1, y: y3))
            }
            
            let p = path.strokedPath(StrokeStyle(lineWidth: l, lineCap: .butt))
            store(path: p)
            return p
        }
        
        private func storedPath() -> Path {
                switch shapeType {
                    case .normal:
                        return LineShape.storedNormalPath
                    case .opposite:
                        return LineShape.storedOppositePath
                }
        }
        
        private func store(path: Path) {
            switch shapeType {
                case .normal:
                    LineShape.storedNormalPath = path
                case .opposite:
                    LineShape.storedOppositePath = path
            }
        }
    }
}



struct AnimatableLine : VectorArithmetic {
    
    
    var values:[Double]
    
    var magnitudeSquared: Double {
        return values.map{ $0 * $0 }.reduce(0, +)
    }
    
    mutating func scale(by rhs: Double) {
        values = values.map{ $0 * rhs }
    }
    
    static var zero: AnimatableLine {
        return AnimatableLine(values: [0.0])
    }
    
    static func - (lhs: AnimatableLine, rhs: AnimatableLine) -> AnimatableLine {
        return AnimatableLine(values: zip(lhs.values, rhs.values).map(-))
    }
    
    static func -= (lhs: inout AnimatableLine, rhs: AnimatableLine) {
        lhs = lhs - rhs
    }
    
    static func + (lhs: AnimatableLine, rhs: AnimatableLine) -> AnimatableLine {
        return AnimatableLine(values: zip(lhs.values, rhs.values).map(+))
    }
    
    static func += (lhs: inout AnimatableLine, rhs: AnimatableLine) {
        lhs = lhs + rhs
    }
}



extension Animation {
    func `do`(while expression: Bool, autoreverses: Bool = true) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}

