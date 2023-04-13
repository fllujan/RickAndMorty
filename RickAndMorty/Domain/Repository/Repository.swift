import Combine

protocol Repository {
    func getCharacters(next: Int, searchText: String) -> AnyPublisher<CharacterAndInfo, Failure>
    func getEpisodes(character: Character) -> AnyPublisher<[Episode], Failure>
}
