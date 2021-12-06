// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation


final class NetworkOperation: AsyncOperation {
    
    var responseCallback: (Response) -> Void = { _ in fatalError() }
    
    private let requestBlock: () -> URLRequest
    private weak var session: URLSession?
    private weak var task: URLSessionTask?
    
    init(session: URLSession, buildRequestBlock: @escaping () -> URLRequest) {
        self.requestBlock = buildRequestBlock
        self.session = session
    }
    
    override func workItem() {
        guard let session = session else {
            markFinished()
            return
        }
        
        let request = requestBlock()
        let task = session.dataTask(with: request) { [unowned self] in
            let response = Response(data: $0, response: $1, error: $2)
            
            syncRESTDispatchQueue.async {
                self.responseCallback(response)
                self.markFinished()
            }
        }
        
        self.task = task
        task.resume()
    }
    
    override func cancel() {
        super.cancel()
        task?.cancel()
    }
}
