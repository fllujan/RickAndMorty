import Combine
@testable import RickAndMorty

class MockLocalDataSourceImpl: LocalDataSource {
    var localCall: Bool = false
    var localCount: Int = 0
    var localError: Bool = false
    
    
    func saveCharacters(characters: [Character]) {
        localCall = true
        localCount += 1
    }
    
    func getCharacters() -> Future<[CharacterDB], Failure> {
        localCall = true
        localCount += 1
        
        return Future<[CharacterDB], Failure> { promesa in
            if self.localError {
                promesa(.failure(.dbError))
            } else {
                promesa(.success([]))
            }
        }
    }
    
    func saveEpisodes(character: Character, episodes: [Episode]) {
        localCall = true
        localCount += 1
    }
    
    func getEpisodes(character: Character) -> Future<[EpisodeDB], Failure> {
        localCall = true
        localCount += 1
        
        return Future<[EpisodeDB], Failure> { promesa in
            if self.localError {
                promesa(.failure(.dbError))
            } else {
                promesa(.success([]))
            }
        }
    }
}
