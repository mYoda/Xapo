// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation


public struct HTTPCode {
    public let code: Int
    
    public var localizedString: String {
        return HTTPURLResponse.localizedString(forStatusCode: code)
    }
    
    public var isSuccess: Bool {
        return (200..<300).contains(code)
    }
    
    public var isClientError: Bool {
        return (400..<500).contains(code)
    }
    
    public var isServerError: Bool {
        return (500..<600).contains(code)
    }
}
