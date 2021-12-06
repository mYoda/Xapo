// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import XCTest
@testable import XapoTest

final class MockDataTest: XCTestCase {
    private let languages = MockData.programmingLanguages
    
    func testDataCount() {
        XCTAssertEqual(languages.count, 10)
    }
    
    func testDataDuplicated() {
        XCTAssertEqual(languages.count, languages.unique.count)
    }
    
    func testProgrammingLanguagesIds() {
        languages.forEach { XCTAssertEqual($0.hashValue, $0.id) }
    }
    
    func testProgrammingLanguagesName() {
        languages.forEach {
            XCTAssertTrue(
                $0.name.isNotEmpty,
                "Failed programming language's name test: \($0.id)"
            )
        }
    }
}
