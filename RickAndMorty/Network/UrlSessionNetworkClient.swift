import Foundation
import Combine

enum HTTPMethod: String {
    case GET
    case POST
}

class UrlSessionNetworkClient: NetworkClient {
    
    func call<T>(with path: String, method: HTTPMethod) -> Future<T, Failure> where T: Codable {
        return Future<T, Failure> { promesa in
            self.createRequest(with: URL(string: Env.variable(.baseURL) + path), type: method) {  request in
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        promesa(.failure(Failure.httpResponseError))
                        return
                    }
                    
                    switch httpResponse.statusCode {
                        case 200...299: break
                        case 404:
                            promesa(.failure(Failure.noFound))
                            return
                        default:
                            promesa(.failure(Failure.statusCodeError))
                            return
                    }
                    
                    guard let data = data else {
                        promesa(.failure(Failure.generic))
                        return
                    }
                    
                    do {
                        let decodeData = try JSONDecoder().decode(T.self, from: data)
                        promesa(.success(decodeData))
                    } catch {
                        promesa(.failure(Failure.couldNotDecodeData))
                    }
                    
                }.resume()
            }
        }
    }
    
    private func createRequest(
        with url: URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void
    ) {
        guard let apiURL = url else { return }
        var request = URLRequest(url: apiURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        completion(request)
    }
}
