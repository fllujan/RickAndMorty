import Combine

struct LocalDataSourceImpl: LocalDataSource {
    
    private let dataBase: DataBaseManager
    
    init(dataBase: DataBaseManager) {
        self.dataBase = dataBase
    }
    
    func saveCharacters(characters: [Character]) {
        dataBase.create(characters: characters)
    }
    
    func saveEpisodes(character: Character, episodes: [Episode]) {
        dataBase.create(episodes: episodes, character: character)
    }
    
    func getCharacters() -> Future<[CharacterDB], Failure> {
        dataBase.read()
    }
    
    func getEpisodes(character: Character) -> Future<[EpisodeDB], Failure> {
        dataBase.read(character: character)
    }
}
