// XapoTest
//
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 

import UIKit
import SwiftUI


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var overlayWindow: OverlayWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let view = RootView()
        self.window = MainWindow(windowScene: windowScene).then {
            $0.backgroundColor = UIColor.white
            $0.rootViewController = MainHostingController(rootView: view)
            $0.windowLevel = .normal
            $0.makeKeyAndVisible()
            $0.overrideUserInterfaceStyle = .light
        }
        
        ///Overlay view to show custom popups over all screens even full screen modals
        overlayWindow = OverlayWindow(windowScene: windowScene).then {
            $0.rootViewController = OverlayViewController(rootView: OverlayView())
            $0.windowLevel = .normal + 1
            $0.overrideUserInterfaceStyle = .light
            $0.makeKeyAndVisible()
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene) {}
}
