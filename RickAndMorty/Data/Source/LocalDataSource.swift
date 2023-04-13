import Combine

protocol LocalDataSource {
    func saveCharacters(characters: [Character]) -> Void
    func getCharacters() -> Future<[CharacterDB], Failure>
    func saveEpisodes(character: Character, episodes: [Episode]) -> Void
    func getEpisodes(character: Character) -> Future<[EpisodeDB], Failure>
}
