// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation


enum RESTError: Error {
    case api(APIError)
    case general(Error)
    case decoding(Error)
    case unknown
}

extension RESTError {
    var message: String {
        switch self {
            case .api(let apiError): return humanMessage(for: apiError)
            case .decoding(let e): return e.localizedDescription
            case .general(let e): return e.localizedDescription
            default:
                return String.Error.undefinedError
        }
    }
    
    var httpCode: HTTPCode? {
        switch self {
            case .api(let apiError):
                return apiError.httpCode
            default: return nil
        }
    }
    
    private func humanMessage(for error: APIError) -> String {
        switch error.httpCode.code {
            case 403: return String.Error.apiRateLimit
            default: return error.message
        }
    }
}


struct APIError: Swift.Error, LocalizedError {
    
    private static let defaultCode = 200
    
    let httpCode: HTTPCode
    let error: String
    let description: String
    let code: Int
    let message: String
    
    init(urlError: URLError) {
        self.httpCode = HTTPCode(code: urlError.code.rawValue)
        self.code = urlError.errorCode
        self.error = "unknown"
        self.description = httpCode.localizedString
        self.message = ""
    }
    
    init(data: Data, httpCode: HTTPCode) {
        self.httpCode = httpCode
        
        guard
            let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let dict = json as? Dictionary<String, Any> else {
            
            self.error = "unknown"
            self.code = APIError.defaultCode
            self.description = httpCode.localizedString
            self.message = ""
            return
        }
        
        self.error = dict["error"] as? String ?? "unknown"
        self.description = dict["error_description"] as? String ?? String(describing: json)
        if let status = dict["status"] as? Int {
            self.code = status
        } else {
            self.code = APIError.defaultCode
        }
        
        self.message = dict["message"] as? String ?? "Unknown"
    }
    
    var errorDescription: String? {
        return description
    }
}


extension APIError {
    var isInternalError: Bool {
        return code >= 400
    }
}


extension Result {
    
    func map<V>(_ transform: (Success) throws -> V) -> Result<V, Failure> where Failure == RESTError {
        switch self {
        case .success(let d):
            do {
                return try .success(transform(d))
            } catch {
                return .failure(.decoding(error))
            }
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func erase() -> Result<Void, Failure> where Failure == RESTError {
        switch self {
        case .success:
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
}
