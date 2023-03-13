import Foundation
import Combine

protocol RemoteDataSource {
    func getCharacters(next: Int) -> Future<CharacterDto, Failure>
    func getEpisodes(episodeId: String) -> Future<[EpisodeDto], Failure>
}
