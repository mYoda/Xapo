// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import Combine


final class RESTClient {
    
    private let baseURL: URL
    private let session: URLSession
    
    private let requestsQueue: OperationQueue = {
        return OperationQueue().then {
            $0.name = "API REST Operations Queue"
            $0.qualityOfService = .userInitiated
        }
    }()
    
    init(baseURL: URL,
         session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        
        self.baseURL = baseURL
        self.session = session
    }
}


//MARK: - Rest HTTP methods
extension RESTClient {
    @discardableResult
    func get(_ path: CustomStringConvertible,
             parameters: RequestParameters = [:],
             completion: @escaping (Response) -> Void) -> Cancellable {
        
        
        let url = baseURL.appendingPathComponent(path.description)
        let operation = NetworkOperation(session: session) { [weak self] in
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            components.queryItems = parameters.map { key, value in
                return URLQueryItem(name: key, value: String(describing: value))
            }
            var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            self?.addAccessToken(to: &request)
            return request
        }
        operation.responseCallback = { [weak self] in
            self?.handleResponse($0)
            completion($0)
        }
        enqueueOperation(operation)
        return operation
    }
    
    @discardableResult
    func post(_ path: CustomStringConvertible,
              queryParameters: RequestParameters = [:],
              parameters: RequestParameters = [:],
              completion: @escaping (Response) -> Void) -> Cancellable {
        
        let url = baseURL.appendingPathComponent(path.description)
        let operation = NetworkOperation(session: session) { [weak self] in
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            components.queryItems = queryParameters.map { key, value in
                return URLQueryItem(name: key, value: String(describing: value))
            }
            var request = URLRequest(url: components.url!)
            request.httpMethod = "POST"
            self?.encodeJSONBody(parameters, in: &request)
            self?.addAccessToken(to: &request)
            return request
        }
        operation.responseCallback = { [weak self] in
            self?.handleResponse($0)
            completion($0)
        }
        enqueueOperation(operation)
        return operation
    }
    
    @discardableResult
    func post<E: Encodable>(_ path: CustomStringConvertible,
                            input: E,
                            queryParameters: RequestParameters = [:],
                            completion: @escaping (Response) -> Void) -> Cancellable {
        
        let url = baseURL.appendingPathComponent(path.description)
        let operation = NetworkOperation(session: session) { [weak self] in
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            components.queryItems = queryParameters.map { key, value in
                return URLQueryItem(name: key, value: String(describing: value))
            }
            var request = URLRequest(url: components.url!)
            request.httpMethod = "POST"
            self?.encode(input, in: &request)
            self?.addAccessToken(to: &request)
            return request
        }
        operation.responseCallback = { [weak self] in
            self?.handleResponse($0)
            completion($0)
        }
        enqueueOperation(operation)
        return operation
    }
    
    @discardableResult
    func put(_ path: CustomStringConvertible,
             queryParameters: RequestParameters = [:],
             parameters: RequestParameters = [:],
             completion: @escaping (Response) -> Void) -> Cancellable {
        
        let url = baseURL.appendingPathComponent(path.description)
        let operation = NetworkOperation(session: session) { [weak self] in
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            components.queryItems = queryParameters.map { key, value in
                return URLQueryItem(name: key, value: String(describing: value))
            }
            var request = URLRequest(url: components.url!)
            request.httpMethod = "PUT"
            self?.encodeJSONBody(parameters, in: &request)
            self?.addAccessToken(to: &request)
            return request
        }
        operation.responseCallback = { [weak self] in
            self?.handleResponse($0)
            completion($0)
        }
        enqueueOperation(operation)
        return operation
    }
    
    @discardableResult
    func put<E: Encodable>(_ path: CustomStringConvertible,
                           input: E,
                           queryParameters: RequestParameters = [:],
                           completion: @escaping (Response) -> Void) -> Cancellable {
        
        let url = baseURL.appendingPathComponent(path.description)
        let operation = NetworkOperation(session: session) { [weak self] in
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            components.queryItems = queryParameters.map { key, value in
                return URLQueryItem(name: key, value: String(describing: value))
            }
            var request = URLRequest(url: components.url!)
            request.httpMethod = "PUT"
            self?.encode(input, in: &request)
            self?.addAccessToken(to: &request)
            return request
        }
        operation.responseCallback = { [weak self] in
            self?.handleResponse($0)
            completion($0)
        }
        enqueueOperation(operation)
        return operation
    }
    
    @discardableResult
    func delete(_ path: CustomStringConvertible,
                parameters: RequestParameters = [:],
                completion: @escaping (Response) -> Void) -> Cancellable {
        
        let url = baseURL.appendingPathComponent(path.description)
        let operation = NetworkOperation(session: session) { [weak self] in
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            components.queryItems = parameters.map { key, value in
                return URLQueryItem(name: key, value: String(describing: value))
            }
            var request = URLRequest(url: components.url!)
            request.httpMethod = "DELETE"
            self?.addAccessToken(to: &request)
            return request
        }
        operation.responseCallback = { [weak self] in
            self?.handleResponse($0)
            completion($0)
        }
        enqueueOperation(operation)
        return operation
    }
}


//MARK: - Actions
extension RESTClient {
    
    private func enqueueOperation(_ operation: NetworkOperation) {
        requestsQueue.addOperation(operation)
    }
    
    private func handleResponse(_ response: Response) {
        if case .failure(let error) = response.result {
            switch error {
            case .api(let apiError) where apiError.httpCode.code == 401:
                logout()
            default:
                break
            }
        }
    }
    
    func logout(fireSignal: Bool = true) {
        syncRESTDispatchQueue.async {
            self._logout(fireSignal: fireSignal)
        }
    }
    
    private func _logout(fireSignal: Bool) {
        dispatchPrecondition(condition: .onQueue(syncRESTDispatchQueue))
        requestsQueue.cancelAllOperations()
    }
}


// MARK: - URLRequest composing
private extension RESTClient {
    
    func addAccessToken(to request: inout URLRequest) {
        /*
        if let accessToken = accessTokenStorage.fetch() {
            request.addValue("Bearer \(accessToken.token)", forHTTPHeaderField: "Authorization")
        }
         */
    }
    
    func encodeJSONBody(_ parameters: RequestParameters, in request: inout URLRequest) {
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
            //print(data.prettyPrintedJSON)
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            fatalError("Can't encode request: \(error)")
        }
    }
    
    func encode<E: Encodable>(_ object: E, in request: inout URLRequest) {
        do {
            let jsonData = try JSONEncoder.default.encode(object)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            }
            
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            fatalError("Can't encode object: \(object)")
        }
    }
}

extension RESTClient {
    func updatingBaseUrl(url: URL) -> RESTClient {
        return RESTClient(baseURL: url, session: self.session)
    }
}
