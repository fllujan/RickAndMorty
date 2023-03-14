import Foundation
import Combine

protocol CharactersProtocol {
    func execute(next: Int, searchText: String) -> AnyPublisher<CharacterAndInfo, Failure>
}
