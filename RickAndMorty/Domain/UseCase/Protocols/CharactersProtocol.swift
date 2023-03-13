import Foundation
import Combine

protocol CharactersProtocol {
    func execute(next: Int) -> AnyPublisher<CharacterAndInfo, Failure>
}
