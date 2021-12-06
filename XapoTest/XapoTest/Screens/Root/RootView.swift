// XapoTest
//
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
//


import SwiftUI


struct RootView: View {
    
    @StateObject private var viewModel = RootVM()
    @State private var blurAppContent: Bool = false
    
    var body: some View {
        ZStack {
            Color.clear.edgesIgnoringSafeArea(.all)
            switch viewModel.navigation {
                case .welcome:
                    WelcomeView()
                case .main:
                    GitHubListView()
                default:
                    WelcomeView()
            }
            
            if blurAppContent {
                Blur(style: .light).edgesIgnoringSafeArea(.all)
            }
        }
        .onReceive(Navigation.current) { n in
            Appearance.statusBar.style.send(n.statusBarSyle)
            withAnimation { viewModel.navigation = n }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            withAnimation { blurAppContent = true }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            withAnimation { blurAppContent = false }
        }
    }
}
