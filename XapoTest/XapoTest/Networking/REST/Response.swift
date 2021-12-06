// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation


struct Response {
    
    let result: Result<Data, RESTError>
    let httpCode: HTTPCode
    let headers: [String: Any]
    
    init(data: Data?, response: URLResponse?, error: Swift.Error?) {
        if let httpResponse = response as? HTTPURLResponse {
            httpCode = HTTPCode(code: httpResponse.statusCode)
            headers = httpResponse.allHeaderFields.mapKeys { $0.description }
        } else {
            httpCode = HTTPCode(code: 0)
            headers = [:]
        }
        
        if let data = data {
            let apiError = APIError(data: data, httpCode: httpCode)
            if httpCode.isSuccess && !apiError.isInternalError {
                result = .success(data)
            } else {
                result = .failure(RESTError.api(apiError))
            }
        } else if let error = error {
            result = .failure(.general(error))
        } else {
            result = .failure(.unknown)
        }
    }
}
