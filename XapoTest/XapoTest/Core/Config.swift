// XapoTest
//    
// Created by Anton Nechayuk © 
// with 🧡 for Xapo in 2021
// 


import Foundation


enum Config {
    
    enum AppLinks {
        case privacy
        case terms
        case homepage
        
        var url: URL {
            switch self {
                case .privacy:  return "https://legal.xapo.com/xapo-privacy-policy/"
                case .terms:    return "https://legal.xapo.com/website-terms-use/"
                case .homepage: return "https://xapo.com"
            }
        }
    }
    
    static let baseUrl: URL = "https://api.github.com"   
    static var currentLanguage: String { "en" }
}
