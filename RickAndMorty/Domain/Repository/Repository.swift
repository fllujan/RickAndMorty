import Foundation
import Combine

protocol Repository {
    func getCharacters(next: Int) -> AnyPublisher<CharacterAndInfo, Failure>
    func getEpisodes(episodeId: String) -> AnyPublisher<[Episode], Failure>
}
