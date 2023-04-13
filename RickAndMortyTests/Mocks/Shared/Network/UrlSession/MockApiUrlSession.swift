import Combine
@testable import RickAndMorty

final class MockApiUrlSession: NetworkClient {
    
    var apiCall: Bool = false
    var apiCount: Int = 0
    var apiError: Bool = false
    var nameJson = ""
    
    func call<T>(with path: String, method: HTTPMethod) -> Future<T, Failure> where T : Decodable, T : Encodable {
        apiCall = true
        apiCount += 1
        
        return Future<T, Failure> { promesa in
            if self.apiError {
                promesa(.failure(.httpResponseError))
            } else {
                guard let data = Util.parseJson(jsonName: self.nameJson, model: T.self) else {
                    promesa(.failure(.jsonDecoder))
                    return
                }
                
                promesa(.success(data))
                
            }
        }
    }
}
