import Foundation
import Combine

class RepositoryImpl: Repository {
   
    private let remoteDataSource: RemoteDataSource
    
    init(remoteDataSource: RemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getCharacters(next: Int, searchText: String) -> AnyPublisher<CharacterAndInfo, Failure> {
        remoteDataSource.getCharacters(next: next, searchText: searchText)
            .map { $0.toCharacterAndInfo }
            .eraseToAnyPublisher()
    }
    
    func getEpisodes(episodeId: String) -> AnyPublisher<[Episode], Failure> {
        remoteDataSource.getEpisodes(episodeId: episodeId)
            .map { $0.toEpisodes }
            .eraseToAnyPublisher()
    }
}
