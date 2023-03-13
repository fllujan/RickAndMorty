import Foundation
import Combine

enum HTTPMethod: String {
    case GET
    case POST
}

class ApiURLSession: ApiUrlSessionProtocol {
    
    func get<T>(with path: String) -> Future<T, Failure> where T: Codable {
        return Future<T, Failure> { promesa in
            self.createRequest(with: URL(string: Env.variable(.baseURL) + path), type: .GET) {  request in
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        promesa(.failure(Failure.httpResponseError))
                        return
                    }
                    
                    if (httpResponse.statusCode > 299){
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
                        print(error)
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
