// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI


struct ListedCellOption<T: Hashable> {
    
    let title: String
    let id: T
    let color: Color
    let config: ListedCellConfig
    
    init(title: String,
         id: T,
         color: Color = .clear,
         config: ListedCellConfig = .default) {
        
        self.title = title
        self.id = id
        self.color = color
        self.config = config
    }
}

struct ListedCellConfig {
    
    static let `default` = ListedCellConfig(isSelected: false, isDisabled: false)
    static let selected = ListedCellConfig(isSelected: true, isDisabled: false)
    static let disabled = ListedCellConfig(isSelected: false, isDisabled: true)
    
    let isSelected: Bool
    let isDisabled: Bool
    
    init(isSelected: Bool = false,
         isDisabled: Bool = false) {
        self.isSelected = isSelected
        self.isDisabled = isDisabled
    }
}

extension PopupsFactory {
    enum ListedPopup { }
}

// MARK: - Body
extension PopupsFactory.ListedPopup {
    
    
    static func make<T: Hashable, CellContent: View, TopBar: View>(
        style: CellFactory.Style,
        data: [ListedCellOption<T>],
        @ViewBuilder topBarContent: @escaping (_ style: CellFactory.Style) -> TopBar,
        @ViewBuilder cellContent: @escaping (_ style: CellFactory.Style, _ item: ListedCellOption<T>) -> CellContent,
        onComplete: @escaping (ListedCellOption<T>?) -> Void ) -> PopupModel where T: Hashable {
        
            return PopupModel(type: CellFactory.Theme.popupType,
                          background: .color(style.backgroundColor),
                          animation: .easeOut,
                          transition: .slide,
                          closeOnDrag: true,
                          closeOnTap: true,
                          closeOnTapOutside: true) { _, hideAction in
                
            VStack(spacing: 0) {

                topBarContent(style)

                ContentSizeFittedScrollView(maxHeight: .heightFromScreen(scale: 0.8)) {
                    Group {
                        VStack(spacing: CellFactory.Theme.cellSpacing) {
                            ForEach(data.enumeratedArray(), id: \.0) { _, item in

                                cellContent(style, item)
                                    .opacityTap() {
                                        hideAction()
                                        onComplete(item)
                                    }

                            }
                            .padding([.leading, .trailing], .smallPadding)
                        }
                    }
                    .padding(.top, CellFactory.Theme.contentPadding)
                    .padding(.bottom, .smallPadding)
                }
            }
            .padding(.bottom, CellFactory.Theme.bottomContentPadding)
            .compositingGroup()
            .asFormBlock(fillColor: style.contentBackgroundColor)
            .frame(maxWidth: CellFactory.Theme.popupContentMaxWidth)
        }
    }
}


//MARK: - Cell Factory
extension PopupsFactory.ListedPopup {
    
    enum CellFactory {
        
        enum Style {
            case dotted
            case text
            
            var titleBarColor: Color {
                switch self {
                    default: return .white
                }
            }
            
            var contentBackgroundColor: Color {
                switch self {
                    default: return .white
                }
            }
            
            var cellHeight: CGFloat {
                switch self {
                    default: return Theme.cellHeight
                }
            }
            
            var topContentPadding: CGFloat {
                switch self {
                    default: return Theme.contentPadding
                }
            }
            
            var backgroundColor: Color {
                switch self {
                    default: return .black.opacity(0.12)
                }
            }
            
            func makeCell<T: Hashable>(_ item: ListedCellOption<T>, selected: Bool = true) -> some View {
                Group {
                    switch self {
                        case .dotted:
                            CellFactory.DotCell(data: item)
                        case .text:
                            CellFactory.TextCell(data: item)
                    }
                }
            }
            
            
            
            func makeTopBar<Item: View>(title: String,
                                        @ViewBuilder leftItem: @escaping () -> Item,
                                        @ViewBuilder rightItem: @escaping () -> AnyView = { EmptyView().asAnyView }) -> some View {
                VStack(spacing: 0) {
                    Primitives.handle
                    
                    VStack(spacing: 0) {
                        
                        ZStack {
                            HStack {
                                leftItem()
                                Spacer(minLength: 0)
                            }
                            HStack {
                                Text(title)
                                    .font(Theme.titleFont)
                                    .foregroundColor(.blackText)
                                    
                            }
                            
                            HStack {
                                Spacer(minLength: 0)
                                rightItem()
                            }
                        }
                        .padding(.top, topContentPadding)
                        .padding(.horizontal, .smallPadding)
                        .padding(.bottom, Theme.contentPadding)
                        
                        
                        Primitives.separator(height: 1)
                    }
                }
                .background(titleBarColor)
                .cornerRadius(Theme.topBarCornerRadius, corners: [.topLeft, .topRight])
            }
            
            private func makeTitleTopBar(title: String) -> some View {
                VStack(spacing: 0) {
                    Primitives.handle
                    
                    VStack(spacing: 0) {
                        HStack(spacing:0) {
                            Text(title)
                                .font(Theme.titleFont)
                                .foregroundColor(.blackText)
                                .padding(.vertical, Theme.contentPadding)
                        }
                        
                        Primitives.separator(height: 1)
                    }
                }
                .background(titleBarColor)
                .cornerRadius(Theme.topBarCornerRadius, corners: [.topLeft, .topRight])
            }
        }
        
        struct DotCell<T>: View where T: Hashable {
            
            let data: ListedCellOption<T>
            
            var body: some View {
                ZStack {
                    RoundedRectangle(cornerRadius: CGFloat.smallCornerRadius)
                        .strokeBorder(Color.border, lineWidth: Theme.borderWidth)
                        .background(RoundedRectangle(cornerRadius: CGFloat.smallCornerRadius).foregroundColor(.white))
                    
                    VStack(spacing: 0) {
                        HStack(spacing: .formSmallPadding) {
                            Circle()
                                .frame(size: Theme.coloredDotSize)
                                .foregroundColor(data.color)
                            
                            Text(data.title)
                                .foregroundColor(.darkGrayText)
                                .font(Theme.cellTitleFont)
                                .lineLimit(1)
                            
                            Spacer(minLength: 0)
                            
                            if data.config.isSelected {
                                Primitives.checkmark
                            }
                        }
                    }
                    .padding(.horizontal, .smallPadding)
                }
                .frame(height: Theme.cellHeight)
            }
        }
        
        struct TextCell<T>: View where T: Hashable {
            
            let data: ListedCellOption<T>
            
            var body: some View {
                ZStack {
                    RoundedRectangle(cornerRadius: CGFloat.smallCornerRadius)
                        .strokeBorder(Color.border, lineWidth: Theme.borderWidth)
                        .background(RoundedRectangle(cornerRadius: CGFloat.smallCornerRadius).foregroundColor(.white))
                    
                    VStack(spacing: 0) {
                        HStack(spacing: .formSmallPadding) {
                            Text(data.title)
                                .foregroundColor(.blackText)
                                .font(Theme.titleFont)
                                .lineLimit(1)
                            
                            Spacer(minLength: 0)
                            
                            if data.config.isSelected {
                                Primitives.checkmark
                            }
                        }
                    }
                    .padding(.horizontal, .smallPadding)
                }
                .frame(height: Theme.cellHeight)
            }
        }
    }
}


//MARK: - Theme
extension PopupsFactory.ListedPopup.CellFactory {
    enum Theme {
        /// San Francisco Text (style: .medium, size: 13)
        static let titleFont: Font = .xapoSecretFont(size: 18, weight: .medium)
        ///
        static let cellTitleFont: Font = .xapoSecretFont(size: 16, weight: .medium)
        /// 0.5
        static let borderWidth: CGFloat = 0.5
        /// 6x6
        static let coloredDotSize = CGSize(uniform: 6)
        /// 44
        static let cellHeight: CGFloat = 50
        /// 17x17
        static let checkmarkSize = CGSize(uniform: 17)
        /// 12
        static let cellSpacing: CGFloat = 12
        /// 12
        static let contentPadding: CGFloat = 12
        /// 10
        static let topBarCornerRadius: CGFloat = 10
        
        
        // use next to adopt for iPads etc..
        
        static var popupType: PopupType { .toast(position: .bottom) }
        
        static var popupContentMaxWidth: CGFloat { .infinity }
        
        static var bottomContentPadding: CGFloat { .safeBottom }
    }
}
