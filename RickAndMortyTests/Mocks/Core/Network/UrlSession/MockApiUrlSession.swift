import Foundation
import Combine
@testable import RickAndMorty

final class MockApiUrlSession: ApiUrlSessionProtocol {
    
    var apiCall: Bool = false
    var apiCount: Int = 0
    var apiError: Bool = false
    var nameJson = ""
    
    func get<T>(with path: String) -> Future<T, Failure> where T : Decodable, T : Encodable {
        apiCall = true
        apiCount += 1
        
        return Future<T, Failure> { promesa in
            if self.apiError {
                promesa(.failure(.httpResponseError))
            } else {
                guard let data = Util.parseJson(jsonName: self.nameJson, mode: T.self) else {
                    promesa(.failure(.jsonDecoder))
                    return
                }
                
                promesa(.success(data))
                
            }
        }
    }
    
    
}
