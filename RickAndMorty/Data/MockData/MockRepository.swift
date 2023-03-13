import Foundation
import Combine

final class MockRepository: Repository {
    
    func getCharacters(next: Int) -> AnyPublisher<CharacterAndInfo, Failure> {
        let response: AnyPublisher<CharacterDto, Failure> = Util.getDataMock(jsonName: "MockCharacters")
        return response.map { $0.toCharacterAndInfo }
            .eraseToAnyPublisher()
    }
    
    func getEpisodes(episodeId: String) -> AnyPublisher<[Episode], Failure> {
        if CommandLine.arguments.contains("mockError") {
            return Result.Publisher(.failure(Failure.httpResponseError)).eraseToAnyPublisher()
        }
        
        let response: AnyPublisher<[EpisodeDto], Failure> = Util.getDataMock(jsonName: "MockEpisodes")
        return response.map { $0.toEpisodes }
            .eraseToAnyPublisher()
    }
}
