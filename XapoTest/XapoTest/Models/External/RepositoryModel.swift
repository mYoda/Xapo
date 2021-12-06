// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation


struct RepositoryModel: Codable {
    let id: Int
    let nodeId: String
    let name: String
    let owner: OwnerModel
    let htmlUrl: URL
    let description: String?
    let language: String?
    let stargazersCount: Int
    
    struct OwnerModel: Codable {
        let login: String
        let id: Int
        let avatarUrl: URL?
    }
}

struct ReposResponse: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [RepositoryModel]
}
