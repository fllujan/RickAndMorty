import Foundation
import Combine
@testable import RickAndMorty

final class MockEpisodesUseCase: EpisodesProtocol {
    
    var isCall: Bool = false
    var countCall: Int = 0
    var isError: Bool = false
    
    func execute(character: Character) -> AnyPublisher<[Episode], Failure> {
        self.isCall = true
        self.countCall += 1
        
        if isError {
            return Result.Publisher(.failure(Failure.httpResponseError)).eraseToAnyPublisher()
        }
        
        return Result.Publisher(.success([MockEpisode.anEpisode()])).eraseToAnyPublisher()
        
    }
}
