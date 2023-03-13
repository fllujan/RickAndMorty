import Foundation
import Combine

protocol ApiUrlSessionProtocol {
    func get<T: Codable>(with path: String) -> Future<T, Failure>
}
