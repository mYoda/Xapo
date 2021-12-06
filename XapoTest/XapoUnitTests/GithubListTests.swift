// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import XCTest
@testable import XapoTest

final class GitHubListTest: XCTestCase {
    private let reqestsLimit = 10 // max allowed from GitHub
    
    func testApiListForAllLanguagesSuccess() {
        let languages = MockData.programmingLanguages.map({ $0.name })
        
        XCTAssertEqual(languages.count, reqestsLimit)
        
        let expectation = self.expectation(description: "API Responds").then {
            $0.expectedFulfillmentCount = languages.count
        }
        
        for language in languages {
            
            API.GitHub.searchRepos(language: language) { result in
                defer { expectation.fulfill() }
                switch result {
                    case .success(let response):
                        XCTAssertTrue(response.items.isNotEmpty)
                    case .failure(let error):
                        XCTAssertTrue(error.message.isNotEmpty)
                        XCTAssertNotNil(error.httpCode)
                }
            }
        }
        
        wait(for: [expectation], timeout: TimeInterval(2 * languages.count))
    }
}
