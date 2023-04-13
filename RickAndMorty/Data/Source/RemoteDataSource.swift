import Combine

protocol RemoteDataSource {
    func getCharacters(next: Int, searchText: String) -> Future<CharacterDto, Failure>
    func getEpisodes(episodeIds: String) -> Future<[EpisodeDto], Failure>
}
