import Foundation
import Combine

final class Util {
    
    static func getDataMock<T: Codable>(jsonName: String) -> AnyPublisher<T, Failure> {
        return Future<T, Failure> { promesa in
            guard let response = Util.parseJson(jsonName: jsonName, model: T.self) else {
                promesa(.failure(.jsonDecoder))
                return
            }
            
            promesa(.success(response))
        }.eraseToAnyPublisher()
    }
    
    static func parseJson<T: Decodable>(jsonName: String, model: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: jsonName, withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            
            do {
                return try jsonDecoder.decode(T.self, from: data)
            } catch {
                return nil
            }
        } catch {
            return nil
        }
    }
}
