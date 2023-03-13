import Foundation
import Combine

protocol EpisodesProtocol {
    func execute(character: Character) -> AnyPublisher<[Episode], Failure>
}
