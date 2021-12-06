// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI


struct GitHubListView: View {
    
    
    @StateObject private var vm = GitHubListViewModel()
    
    @State private var refreshing: Bool = false
    @State private var isFocused: Bool = false
    
    private var expandedId: Int {
        get { vm.expandedId }
        nonmutating set { vm.expandedId = newValue }
    }
    
    
    var body: some View {
        Screen(color: .backgroundDark) {
            RefreshableScrollView(refreshing: $refreshing) {
                VStack(spacing: 0) {
                    
                    header
                        .multilineTextAlignment(.center)
                        .padding(.top, .extraPadding)
                        .padding(.horizontal, .padding)
                    
                    menu
                        .padding(.top, .padding)
                    
                    list
                        .padding(.top, .padding)
                    
                    Spacer(minLength: 0)
                }
                .frame(minHeight: .contentHeight())
            }
        }
        .onAppear { vm.load(with: .default) }
        .onChange(of: refreshing) { isRefreshing in
            guard isRefreshing else { return }
            withAnimation { expandedId = Const.defaultNestedItemId }
            vm.refresh {
                self.refreshing = false
            }
        }
    }
}


//MARK: - Subviews
extension GitHubListView {
    
    private var infoText: String {
        vm.data.isEmpty ? String.GitHub.mostPopular : String.GitHub.info(vm.data.count)
    }
    
    private var header: some View {
        VStack(spacing: .padding) {
            Text(String.GitHub.title)
                .font(Theme.screenTitleFont)
            
            Text(infoText)
                .font(Theme.infoTextFont)
        }
        .foregroundColor(.whiteText)
    }
    
    private var menu: some View {
        HStack(spacing: .formPadding) {
            ForEach(vm.lastTwoSelected.enumeratedArray(), id: \.0) { index, item in
                let color: Color = index == 0 ? .orangeElement : .greenElement
                Buttons.strokedRectangle(title: item.name,
                                         font: Theme.menuFont,
                                         textColor: .whiteText,
                                         backgroundColor: color,
                                         strokeColor: color,
                                         cornerRadius: Theme.menuCornerRadius,
                                         isSelected: (item == vm.selectedLanguage),
                                         action: {
                    onSelectLanguageButton(language: item)
                })
            }
            
            Buttons.strokedRectangle(title: String.GitHub.more,
                                     font: Theme.menuFont,
                                     textColor: .whiteText,
                                     backgroundColor: .coralElement,
                                     strokeColor: .coralElement,
                                     cornerRadius: Theme.menuCornerRadius,
                                     action: {
                onMoreButton()
            })
        }
    }
    
    private var list: some View {
        VStack(spacing: 0) {
            ForEach(vm.data.enumeratedArray(), id: \.0) { _, item in
                Cell(item: item, isExpanded: item.id == expandedId)
                    .opacityTap {
                        withAnimation(.easeOut(duration: 0.15)) { expandedId = expandedId == item.id ? -1 : item.id }
                        Haptic.impact(.light).generate()
                    }
            }
            .padding(.top, .formPadding)
            .padding(.horizontal, .padding)
        }
    }
}


//MARK: - Interactions
extension GitHubListView {
    
    private func onSelectLanguageButton(language: ProgrammingLanguage) {
        vm.load(with: language)
        Haptic.impact(.light).generate()
    }
    
    private func onMoreButton() {
        vm.chooseLanguagePopup()
        Haptic.impact(.light).generate()
    }
}


// MARK: - Theme
extension GitHubListView {
    enum Theme {
        
        /// xapoSecretFont(size: 50, weight: .medium)
        static let screenTitleFont: Font = .xapoSecretFont(size: 50, weight: .medium)
        /// xapoSecretFont(size: 20, weight: .medium)
        static let infoTextFont: Font = .xapoSecretFont(size: 20, weight: .medium)
        /// xapoSecretFont(size: 20, weight: .medium)
        static let menuFont: Font = .xapoSecretFont(size: CGFloat.heightFromScreen(scale: 0.02), weight: .medium)
        /// 30
        static let menuCornerRadius: CGFloat = 30
        /// 1.5
        static var animationDelay: CGFloat {
            #if DEBUG
            return 0.5
            #else
            return 1.5
            #endif
        }
    }
}


//MARK: - Const
extension GitHubListView {
    enum Const {
        static let defaultNestedItemId = -1
    }
}
