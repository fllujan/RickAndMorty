import Foundation
import Combine

protocol RemoteDataSource {
    func getCharacters(next: Int, searchText: String) -> Future<CharacterDto, Failure>
    func getEpisodes(episodeId: String) -> Future<[EpisodeDto], Failure>
}
