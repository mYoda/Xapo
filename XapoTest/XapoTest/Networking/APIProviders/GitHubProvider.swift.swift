// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import Combine

extension API {
    enum GitHub {
        @discardableResult
        static func searchRepos(language: String, count: Int = 30, completion: @escaping (Result<ReposResponse, RESTError>) -> Void) -> Cancellable {
            let parameters: RequestParameters = [
                "q": "stars:>=1000+language:\(language)",
                "sort": "stars",
                "order": "desc",
                "per_page": count,
            ]
            return client.get("/search/repositories", parameters: parameters) {
                completion($0.result.map {
                    try JSONDecoder.snakeCased.decode(ReposResponse.self, from: $0)
                })
            }
        }
    }
}
