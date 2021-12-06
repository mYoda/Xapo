// XapoTest
//    
// Created by Anton Nechayuk © 
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI
import Combine


class BaseHostingController<T: View>: UIHostingController<T> {
    
    private var isStatusBarHidden: Bool = true {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    private var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    override init(rootView: T) {
        super.init(rootView: rootView)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private var statusBarStyleObserver: AnyCancellable?
    private var statusBarVisibilityObserver: AnyCancellable?
    
    private func setup() {
        statusBarStyleObserver = Appearance.statusBar.style.sink { [weak self] style in
            self?.statusBarStyle = style
        }
        
        statusBarVisibilityObserver = Appearance.statusBar.isHidden.sink { [weak self] isHidden in
            self?.isStatusBarHidden = isHidden
        }
    }
}
