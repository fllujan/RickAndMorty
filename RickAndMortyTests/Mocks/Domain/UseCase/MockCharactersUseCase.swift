import Foundation
import Combine
@testable import RickAndMorty

final class MockCharactersUseCase: CharactersProtocol {
    
    var isCall: Bool = false
    var countCall: Int = 0
    var isError: Bool = false
    
    func execute(next: Int, searchText: String) -> AnyPublisher<CharacterAndInfo, Failure> {
        self.isCall = true
        self.countCall += 1
        
        if isError {
            return Result.Publisher(.failure(Failure.httpResponseError)).eraseToAnyPublisher()
        }
        
        return Result.Publisher(.success(([MockCharacter.anCharacter()], MockInfo.anInfo()))).eraseToAnyPublisher()
    }
}
