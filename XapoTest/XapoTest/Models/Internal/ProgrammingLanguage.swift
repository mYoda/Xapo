// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation


struct ProgrammingLanguage: Hashable {
    var id: Int {
        name.hashValue
    }
    let name: String
}

extension ProgrammingLanguage {
    static let `default` = ProgrammingLanguage(name: "Swift")
}
