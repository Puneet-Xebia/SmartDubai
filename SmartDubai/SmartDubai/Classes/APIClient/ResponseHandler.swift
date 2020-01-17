import Foundation

protocol APIResponseRepresentable {
    
    func handleResponse<T: Codable>(responseData data: Data?,
                                    urlResponse response: URLResponse?,
                                    errorObj error: Error?,
                                    completionHandler: (_ object:T?,_ error: String?)->()) -> Void
}




extension APIResponseRepresentable {
    func handleResponse<T: Codable>(responseData data: Data?,
                                    urlResponse response: URLResponse?,
                                    errorObj error: Error?,
                                    completionHandler: (_ object:T?,_ error: String?)->()) -> Void {
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return
        }
        
        let result = self.handleNetworkResponse(httpResponse)
        switch result {
        case .success:
            guard let responseData = data else {
                //requestCompletion(nil, NetworkResponse.noData.rawValue)
                return
            }
            do {
                //print(responseData)
                let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                print(jsonData)
                let modeledResponse = try JSONDecoder().decode(T.self, from: responseData)
                completionHandler(modeledResponse,nil)
            }catch {
                print(error)
            }
            print("")
        case .failure( _):
            print("")
        }
    }
}

extension APIResponseRepresentable {
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200: return .success
        case 422: return .failure(ErrorResponse(rawValue: ErrorResponse.serverValidationError.rawValue)!)
        case 500: return .failure(ErrorResponse(rawValue: ErrorResponse.internalServerError.rawValue)!)
        default: return .failure(ErrorResponse(rawValue: ErrorResponse.unknownError.rawValue)!)
        }
    }
}
