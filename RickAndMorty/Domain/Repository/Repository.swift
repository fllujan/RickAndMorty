import Foundation
import Combine

protocol Repository {
    func getCharacters(next: Int, searchText: String) -> AnyPublisher<CharacterAndInfo, Failure>
    func getEpisodes(episodeId: String) -> AnyPublisher<[Episode], Failure>
}
