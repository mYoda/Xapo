// XapoTest
//    
// Created by Anton Nechayuk © 
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI


final class OverlayWindow: UIWindow {
    
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.backgroundColor = .clear
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView != self,
           Global.rootPopupsContext.popups.isEmpty,
           Global.overlaysBroker.overlays.isEmpty {
            return nil
        }
        return hitView
    }
}


final class OverlayViewController<T: View>: BaseHostingController<T> {
    
    override init(rootView: T) {
        super.init(rootView: rootView)
        setup()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .clear
    }
}


struct OverlayView: View {
    
    @State private var overlays: [OverlaysBroker.Overlay] = []
    
    var body: some View {
        ZStack {
            ForEach(overlays) { info in
                info.view.screenSized
            }
            
            PopupsStack(context: Global.rootPopupsContext)
                .edgesIgnoringSafeArea(.all)
        }
        .ignoresSafeArea(.keyboard)
        .onReceive(Global.overlaysBroker.$overlays) { info in
            overlays = info
        }
    }
}

