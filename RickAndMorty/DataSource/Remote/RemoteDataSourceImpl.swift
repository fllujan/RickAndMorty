import Foundation
import Combine

struct RemoteDataSourceImpl: RemoteDataSource {
   
    private let api: ApiUrlSessionProtocol
    
    init(api: ApiUrlSessionProtocol) {
        self.api = api
    }
    
    func getCharacters(next: Int) -> Future<CharacterDto, Failure> {
        api.get(with: "/character/?page=\(next)")
    }
    
    func getEpisodes(episodeId: String) -> Future<[EpisodeDto], Failure> {
        api.get(with: "/episode/\(episodeId)")
      
    }
    
}
