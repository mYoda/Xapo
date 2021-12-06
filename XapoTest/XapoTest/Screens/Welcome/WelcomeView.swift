// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import SwiftUI


struct WelcomeView: View {
    
    @State private var animationFinished: Bool = false
    @State private var startAnimation: Bool = false
    
    
    var body: some View {
        Screen(color: .backgroundGray) {
            
            mainContent
                .greedyFrame(alignment: .center)
                .offset(y: animationFinished ? Theme.yContentOffset : 0)
            
            topLinkButton
                .padding(.top, Theme.linkButtonTopPadding)
                .padding(.trailing, Theme.linkButtonTrailing)
                .greedyFrame(alignment: .topTrailing)
                .opacity(animationFinished ? 1 : 0)
            
            footerView
                .padding(.bottom, Theme.bottomViewPadding)
                .padding(.horizontal, Theme.hButtonPadding)
                .greedyFrame(alignment: .bottom)
                .opacity(animationFinished ? 1 : 0)
        }
        .onAppear {
            startAnimation = true
        }
        .onChange(of: startAnimation, perform: { value  in
            if value {
                delay(Theme.logoAnimationDuration) {
                    withAnimation {
                        animationFinished = true
                    }
                }
            }
        })
    }
    
    private var mainContent: some View {
        VStack(spacing: Theme.mainContentSpacing) {
            
            XapoLogoShape(mode: .repeatCount(1),
                          animated: $startAnimation,
                          shapeHeight: Theme.logoSize.height,
                          duration: Theme.logoAnimationDuration / 2,
                          delay: Theme.logoAnimationDuration / 2)
                .frame(size: Theme.logoSize)
                .rotationEffect(Angle(degrees: startAnimation ? 360.0 * (Theme.logoAnimationDuration * 2.0) : 0.0))
                .animation(Animation.timingCurve(0.01, 0.02, 0.5, 1.0, duration: Theme.logoAnimationDuration)
                            .repeatCount(1, autoreverses: false), value: startAnimation)
            
            if startAnimation {
                VStack(spacing: Theme.mainContentSpacing) {
                    
                    Text(String.Welcome.title)
                        .font(Theme.titleFont)
                        .lineSpacing(Theme.titleLineSpacing)
                        .lineLimit(Theme.titleLineLimit)
                        .padding(.horizontal, Theme.hTextPadding)
                    
                    VStack(spacing: Theme.textPadding) {
                        
                        Text(String.Welcome.info)
                        
                        Text(String.Welcome.textPlaceholder)
                            .lineSpacing(Theme.infoLineSpacing)
                            .lineLimit(Theme.infoLineLimit)
                    }
                    .font(Theme.infoTextFont)
                    .padding(.horizontal, Theme.hTextPadding)
                }
                .foregroundColor(.whiteText)
                .multilineTextAlignment(.center)
                .opacity(animationFinished ? 1 : 0)
            }
        }
    }
    
    private var topLinkButton: some View {
        HStack(spacing: 0) {
            Spacer(minLength: 0)
            
            Link(destination: Config.AppLinks.homepage.url,
                 label: {
                Text(String.Welcome.goToXapo)
                    .font(Theme.linkButtonFont)
                    .foregroundColor(.whiteText)
            })
        }
    }
    
    private var footerView: some View {
        VStack(spacing: Theme.termsTopPadding) {
            
            Buttons.sizedRectangle(title: String.Welcome.enterTeApp,
                                   maxHeight: Theme.buttomHeight,
                                   font: Theme.buttonFont,
                                   textColor: .whiteText,
                                   backgroundColor: Color.coral,
                                   cornerRadius: Theme.buttomHeight / 2,
                                   action: { enter() })
            
            HStack(spacing: 0) {
                
                Link(destination: Config.AppLinks.terms.url,
                     label: {
                    Text(String.Welcome.privacy)
                        .underline()
                })
                
                Text(String.Welcome.and)
                
                Link(destination: Config.AppLinks.terms.url,
                     label: {
                    Text(String.Welcome.termsOfUse)
                        .underline()
                })
            }
            .foregroundColor(.lightGrayText)
            .font(Theme.termsFont)
        }
    }
}


//MARK: - Actions
extension WelcomeView {
    private func enter() {
        Navigation.current.send(.main)
    }
}



extension WelcomeView {
    enum Theme {
        
        // - Animation
        /// 5.0
        static let logoAnimationDuration: CGFloat = 6.0
        
        
        // - Content View
        
        /// 100x100 * scaleDown
        static var logoSize: CGSize { CGSize(uniform: 100 * scaleDown) }
        /// 25 * scaleDown
        static var textPadding: CGFloat { 25 * Theme.scaleDown }
        /// 25 * scaleUp
        static var hTextPadding: CGFloat { 25 * Theme.scaleUp }
        /// 20 * scaleDown
        static var mainContentSpacing: CGFloat { 20 * Theme.scaleDown }
        /// 17 * scaleDown
        static var linkButtonTrailing: CGFloat { 17 * scaleDown }
        /// xapoSecretFont(size: 16 * scaleDownFactor, weight: .medium)
        static var linkButtonFont: Font {
            .xapoSecretFont(size: 16 * scaleDown, weight: .medium)
        }
        /// xapoSecretFont(size: 40 * scaleDownFactor, weight: .medium)
        static var titleFont: Font {
            .xapoSecretFont(size: 40 * scaleDown, weight: .medium)
        }
        /// 4 * scaleDown
        static var titleLineSpacing: CGFloat { 4 * scaleDown }
        /// 2
        static let titleLineLimit: Int = 2
        /// xapoSecretFont(size: 16 * scaleDownFactor, weight: .regular)
        static var infoTextFont: Font {
            .xapoSecretFont(size: 16 * scaleDown, weight: .regular)
        }
        /// 4
        static let infoLineLimit: Int = 4
        /// 4
        static let infoLineSpacing: CGFloat = 4
        /// - (20 * 2 * offsetScale)
        static var yContentOffset: CGFloat { -20 * 2 * offsetScale }
        
        
        // - Link Button
        
        /// computed result excluding safeTop for TouchID devices
        static var linkButtonTopPadding: CGFloat {
            (CGFloat.safeTop <= 20 ? 15 : 35) * scaleDown
        }
        
        
        // - Footer View
        
        /// xapoSecretFont(size: 16 * scaleDown, weight: .medium)
        static var buttonFont: Font {
            .xapoSecretFont(size: 16 * scaleDown, weight: .medium)
        }
        /// 48 * scaleDown
        static var buttomHeight: CGFloat { 48 * scaleDown }
        /// 18
        static var bottomViewPadding: CGFloat { 18 }
        /// 18 * scaleUp
        static var termsTopPadding: CGFloat { 18 * scaleUp }
        /// 32 * scaleUp
        static var hButtonPadding: CGFloat { 32 * scaleUp }
        /// xapoSecretFont(size: 13 * scaleDown, weight: .regular)
        static var termsFont: Font {
            .xapoSecretFont(size: 13 * scaleDown, weight: .regular)
        }
        
        
        // - Scales
        
        private static var scaleUp: CGFloat {
            getScale(alpha: scaleUpAlpha, scaleUp: true)
        }
        
        private static var offsetScale: CGFloat {
            getScale(alpha: logoPaddingAlipha, scaleUp: true)
        }
        
        private static var scaleDown: CGFloat {
            getScale(alpha: scaleDownAlpha, scaleUp: false)
        }
        
        /// 0.1
        private static let scaleDownAlpha: CGFloat = 0.1
        /// 0.9
        private static let scaleUpAlpha: CGFloat = 0.9
        /// 0.6
        private static let logoPaddingAlipha: CGFloat = 0.6
        
        private static func getScale(alpha: CGFloat = 0.1, scaleUp: Bool = false, h0: CGFloat = UIScreen.main.bounds.height) -> CGFloat {
            let h1: CGFloat = 568
            let h2: CGFloat = 812
            let x = ((h0 - h1) * alpha / (h2 - h1))
            return scaleUp ? 1 + x : 1 - x
        }
    }
}

