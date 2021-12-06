// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import SwiftUI


extension GitHubListView {
    
    struct Cell: View {
        
        let item: RepositoryModel
        let isExpanded: Bool
        
        private var logo: URL? { item.owner.avatarUrl }
        private var ownerName: String { item.owner.login }
        private var starCount: String { "\(item.stargazersCount)" }
        private var starCountShorted: String { "\(item.stargazersCount.suffixNumber)" }
        private var duration: Double { animateExpanded ? 0.4 : 0.25 }
        private var repoName: String { item.name.capitalized }
        private var repoDescription: String? { item.description }
        private var viewMoreUrl: URL { item.htmlUrl }
        
        @State private var animateExpanded: Bool = false
        
        var body: some View {
            VStack(spacing: 0) {
                
                rowView
                    .padding(.padding)
                
                if isExpanded {
                    nestedView
                        .padding(.top, .microPadding)
                }
            }
            .background(Color.background
                            .cornerRadius(Theme.cellCornerRadiusSmall, corners: [.bottomLeft, .topRight])
                            .cornerRadius(Theme.cellCornerRadiusBig, corners: [.topLeft, .bottomRight]))
            .onAppear { animateExpanded = isExpanded }
            .onChange(of: isExpanded) { newValue in animateExpanded = newValue }
        }
        
        private var rowView: some View {
            HStack(spacing: .formPadding) {
                
                AsyncImage(url: logo,
                           defaultImage: { Design.Brand.xapoLogo.resizable() })
                    .aspectRatio(contentMode: .fit)
                    .frame(size: Theme.avatarImageSize)
                    .clipShape(Circle())
                    .id(logo.hashValue)
                
                VStack(alignment: .leading, spacing: .formSmallPadding) {
                    
                    HStack(spacing: 0) {
                        
                        Text(ownerName)
                            .font(Theme.ownerNameFont)
                            .foregroundColor(.grayText)
                            .lineLimit(1)
                        
                        
                        Spacer(minLength: .formPadding)
                        
                        
                        Design.Icons.star
                            .renderingMode(.template)
                            .foregroundColor(.orange)
                            .offset(y: -2)
                            .rotationEffect(Angle(degrees: animateExpanded ? -360 : 0))
                            .animation(.easeIn(duration: duration), value: animateExpanded)
                        
                        Text(animateExpanded ? starCount : starCountShorted)
                            .font(Theme.starCountFont)
                            .foregroundColor(.grayText)
                            .lineLimit(1)
                            .padding(.leading, .nanoPadding)
                            .frame(minWidth: Theme.starCountMinWidth, idealWidth: .infinity, alignment: .leading)
                            .animation(.easeIn(duration: duration), value: animateExpanded)
                    }
                    
                    Text(repoName)
                        .font(Theme.repositoryNameFont)
                        .foregroundColor(.darkGrayText)
                        .lineLimit(2)
                }
            }
        }
        
        private var nestedView: some View {
            VStack(alignment: .leading, spacing: .padding) {
                
                if let text = repoDescription {
                    Text(text)
                        .font(Theme.descriptionFont)
                        .lineSpacing(.lineSpacing)
                        .lineLimit(Theme.descriptionLineLimit)
                        .foregroundColor(.darkGrayText)
                        .padding(.horizontal, .padding)
                }
                
                Link(destination: viewMoreUrl) {
                    HStack(spacing: 0) {
                        Spacer()
                        Text(String.Welcome.viewDetails)
                            .font(Theme.viewMoreFont)
                            .foregroundColor(Color.brownText)
                        Spacer()
                    }
                }
                .padding(.vertical, .padding)
                .background(Color.backgroundOrangeLight
                                .cornerRadius(Theme.cellCornerRadiusSmall, corners: .bottomLeft)
                                .cornerRadius(Theme.cellCornerRadiusBig, corners: .bottomRight))
            }
        }
    }
}


//MARK: - Theme
extension GitHubListView.Cell {
    enum Theme {
        /// 16
        static let cellCornerRadiusBig: CGFloat = .middleCornerRadius
        /// 4
        static let cellCornerRadiusSmall: CGFloat = 4
        /// 40x40
        static let avatarImageSize = CGSize(uniform: 40)
        /// xapoSecretFont(size: 13, weight: .medium)
        static let ownerNameFont: Font = .xapoSecretFont(size: 13, weight: .medium)
        /// xapoSecretFont(size: 16, weight: .medium)
        static let starCountFont: Font = .xapoSecretFont(size: 16, weight: .medium)
        /// 20
        static let starCountMinWidth: CGFloat = 20
        /// xapoSecretFont(size: 18, weight: .medium)
        static let repositoryNameFont: Font = .xapoSecretFont(size: 18, weight: .medium)
        /// xapoSecretFont(size: 14, weight: .regular)
        static let descriptionFont: Font = .xapoSecretFont(size: 14, weight: .regular)
        /// 15
        static let descriptionLineLimit: Int = 15
        /// .xapoSecretFont(size: 18, weight: .medium)
        static let viewMoreFont: Font = .xapoSecretFont(size: 18, weight: .medium)
    }
}
