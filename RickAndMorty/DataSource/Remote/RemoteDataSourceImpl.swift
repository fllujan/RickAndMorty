import Foundation
import Combine

struct RemoteDataSourceImpl: RemoteDataSource {
   
    private let api: ApiUrlSessionProtocol
    
    init(api: ApiUrlSessionProtocol) {
        self.api = api
    }
    
    func getCharacters(next: Int, searchText: String) -> Future<CharacterDto, Failure> {
        var path = "/character/?page=\(next)"
        if !searchText.isEmpty {
            path += "&name=\(searchText)"
        }
        return api.get(with: path)
    }
    
    func getEpisodes(episodeId: String) -> Future<[EpisodeDto], Failure> {
        api.get(with: "/episode/\(episodeId)")
      
    }
    
}
