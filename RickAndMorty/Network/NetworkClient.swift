import Combine

protocol NetworkClient {
    func call<T: Codable>(with path: String, method: HTTPMethod) -> Future<T, Failure>
}
