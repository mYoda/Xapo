// XapoTest
//
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
//


import Foundation
import SwiftUI
import Combine


final class MainHostingController<T: View>: BaseHostingController<T> {

    var willTransitionFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        willTransitionFlag = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if willTransitionFlag {
            willTransitionFlag = false
            processSpitModeEvent()
        }
    }
    
    private func processSpitModeEvent() {
//        DeviceInfo.splitModeDidChanged.send(Void())
    }
}
