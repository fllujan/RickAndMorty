import Combine

protocol DataBaseManager {
    func create(characters: [Character]) -> Void
    func create(episodes: [Episode], character: Character) -> Void
    func read() -> Future<[CharacterDB], Failure>
    func read(character: Character) -> Future<[EpisodeDB], Failure>
}
