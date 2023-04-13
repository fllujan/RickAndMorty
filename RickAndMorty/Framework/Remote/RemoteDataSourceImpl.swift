import Combine

struct RemoteDataSourceImpl: RemoteDataSource {
   
    private let api: NetworkClient
    
    init(api: NetworkClient) {
        self.api = api
    }
    
    func getCharacters(next: Int, searchText: String) -> Future<CharacterDto, Failure> {
        var path = "/character/?page=\(next)"
        if !searchText.isEmpty {
            path += "&name=\(searchText)"
        }
        return api.call(with: path, method: .GET)
    }
    
    func getEpisodes(episodeIds: String) -> Future<[EpisodeDto], Failure> {
        api.call(with: "/episode/\(episodeIds)", method: .GET)
    }
}
