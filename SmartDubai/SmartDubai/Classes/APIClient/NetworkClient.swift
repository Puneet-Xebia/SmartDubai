import Foundation


public typealias NetworkRouterCompletionHandler = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    func loadRequest(_ request: URLRequest, completion: @escaping NetworkRouterCompletionHandler)
    func cancel()
}

internal final class NetworkClient: NetworkRouter {
    private var task: URLSessionTask?
    
    func loadRequest(_ request : URLRequest, completion: @escaping NetworkRouterCompletionHandler) {
        let session = URLSession.shared
        do {
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                DispatchQueue.main.async {
                    completion(data, response, error)
                }
            })
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
}

