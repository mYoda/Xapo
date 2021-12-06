// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation


open class AsyncOperation : Operation {
    public enum State {
        case ready
        case executing
        case finished
        
        fileprivate var key: String {
            switch self {
            case .ready:
                return "isReady"
            case .executing:
                return "isExecuting"
            case .finished:
                return "isFinished"
            }
        }
    }
    
    fileprivate(set) public var state = State.ready {
        willSet {
            willChangeValue(forKey: state.key)
            willChangeValue(forKey: newValue.key)
        }
        didSet {
            didChangeValue(forKey: oldValue.key)
            didChangeValue(forKey: state.key)
        }
    }
    
    final override public var isAsynchronous: Bool {
        return true
    }
    
    final override public var isExecuting: Bool {
        return state == .executing
    }
    
    final override public var isFinished: Bool {
        return state == .finished
    }
    
    final override public var isReady: Bool {
        return state == .ready && super.isReady
    }
    
    final public func markFinished() {
        if state != .finished {
            state = .finished
        }
    }
    
    final override public func start() {
        if isCancelled {
            state = .finished
            return
        }
        
        main()
    }
    
    final override public func main() {
        if isCancelled {
            state = .finished
            return
        }
        
        state = .executing
        workItem()
    }
    
    /// You **should** override this method and start and/or do your async work here.
    ///  **Must** call `markFinished()` inside your override
    ///  when async work is done since operation needs to be mark `finished`.
    open func workItem() {
        fatalError("You should override `workItem` method in your subclass")
    }
}
