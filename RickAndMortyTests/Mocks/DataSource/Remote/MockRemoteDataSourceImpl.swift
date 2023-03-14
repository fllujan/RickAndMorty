import Combine
@testable import RickAndMorty


final class MockRemoteDataSourceImpl: RemoteDataSource {
    
    var remoteCall: Bool = false
    var remoteCount: Int = 0
    var remoteError: Bool = false
    
    func getCharacters(next: Int, searchText: String) -> Future<CharacterDto, Failure> {
        remoteCall = true
        remoteCount += 1
        
        return Future<CharacterDto, Failure> { promise in
            if self.remoteError {
                promise(.failure(.httpResponseError))
            } else {
                promise(.success(MockCharacterDto.anCharacterDto()))
            }
        }
    }
    
    func getEpisodes(episodeId: String) -> Future<[EpisodeDto], Failure> {
        remoteCall = true
        remoteCount += 1
        
        return Future<[EpisodeDto], Failure> { promise in
            if self.remoteError {
                promise(.failure(.httpResponseError))
            } else {
                promise(.success([MockEpisodeDto.anEpisodeDto()]))
            }
        }
    }
    
}
