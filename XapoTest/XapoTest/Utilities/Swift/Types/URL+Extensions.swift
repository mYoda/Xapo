// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation

extension URL: ExpressibleByStringLiteral {

    public init(stringLiteral value: StringLiteralType) {
        guard let url = URL(string: value) else {
            fatalError("Could not create URL from: \(value)")
        }
        
        self = url
    }

    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        guard let url = URL(string: value) else {
            fatalError("Could not create URL from: \(value)")
        }
        
        self = url
    }

    public init(unicodeScalarLiteral value: StringLiteralType) {
        guard let url = URL(string: value) else {
            fatalError("Could not create URL from: \(value)")
        }
        
        self = url
    }
}


/**
 Append a path component to a url. Equivalent to `lhs.appendingPathComponent(rhs)`.

 - parameter lhs: The url.
 - parameter rhs: The path component to append.
 - returns: The original url with the appended path component.
 */
public func + (lhs: URL, rhs: String) -> URL {
    return lhs.appendingPathComponent(rhs)
}


extension URL {
    public var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else {
            return nil
        }
        
        var parameters: [String: String] = [:]
        for item in queryItems {
            parameters[item.name] = item.value ?? ""
        }
        return parameters
    }
}

import UIKit

extension URL {
    /// "/"
    static let root: URL = "/"
    /// "about:blank"
    static let aboutBlank: URL = "about:blank"
    /// to open mail app
    static let mailApp: URL = "message://"

    var isValid: Bool {
        guard absoluteString.isValidURL else { return false }
        return UIApplication.shared.canOpenURL(self)
    }
}

extension Optional where Wrapped == URL {
    var isValid: Bool {
        guard let url = self else { return false }
        return url.isValid
    }
}

extension String {

    var isValidURL: Bool {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return false }
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}
