import Combine

final class RepositoryImpl: Repository {
   
    private let remoteDataSource: RemoteDataSource
    private let localDataSource: LocalDataSource
    private let connectivity: ConnectivityManager
    
    init(remoteDataSource: RemoteDataSource, localDataSource: LocalDataSource, connectivity: ConnectivityManager) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        self.connectivity = connectivity
    }
    
    func getCharacters(next: Int, searchText: String) -> AnyPublisher<CharacterAndInfo, Failure> {
        if connectivity.isConnectedToNetwork {
            return handleResult(
                future: remoteDataSource.getCharacters(next: next, searchText: searchText),
                transform: { $0.toCharacterAndInfo },
                saveLocal: { [weak self] in self?.localDataSource.saveCharacters(characters: $0.characters) }
            )
        }
        
        return handleResult(
            future: localDataSource.getCharacters(),
            transform: { $0.toCharacterAndInfo }
        )
    }
    
    func getEpisodes(character: Character) -> AnyPublisher<[Episode], Failure> {
        if connectivity.isConnectedToNetwork {
            return handleResult(
                future: remoteDataSource.getEpisodes(episodeIds: character.episodeIds),
                transform: { $0.toEpisodes },
                saveLocal: { [weak self] in self?.localDataSource.saveEpisodes(character: character, episodes: $0) }
            )
        }
        
        return handleResult(
            future: localDataSource.getEpisodes(character: character),
            transform: { $0.toEpisodes }
        )
    }
}
