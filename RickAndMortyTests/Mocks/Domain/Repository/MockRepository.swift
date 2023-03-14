import Combine
@testable import RickAndMorty

final class MockRepository: Repository {
    
    var repoCall: Bool = false
    var repoCount: Int = 0
    var repoError: Bool = false
    
    func getCharacters(next: Int, searchText: String) -> AnyPublisher<CharacterAndInfo, Failure> {
        repoCall = true
        repoCount += 1
        
        if repoError {
            return Result.Publisher(.failure(Failure.httpResponseError)).eraseToAnyPublisher()
        }
        
        return Result.Publisher(.success(([MockCharacter.anCharacter()], MockInfo.anInfo()))).eraseToAnyPublisher()
    }
    
    func getEpisodes(episodeId: String) -> AnyPublisher<[Episode], Failure> {
        repoCall = true
        repoCount += 1
        
        if repoError {
            return Result.Publisher(.failure(Failure.httpResponseError)).eraseToAnyPublisher()
        }
        
        return Result.Publisher(.success([MockEpisode.anEpisode()])).eraseToAnyPublisher()
    }
    
    
}
