import Combine
@testable import RickAndMorty

class MockSearchCharacterUseCase: SearchCharactersUseCase {
    
    var isCall: Bool = false
    var countCall: Int = 0
    var isError: Bool = false
    
    override func run(params: CurrentValueSubject<String, Failure>) -> AnyPublisher<String, Failure> {
        self.isCall = true
        self.countCall += 1
        
        if isError {
            return Result.Publisher(.failure(Failure.generic)).eraseToAnyPublisher()
        }

        return Result.Publisher(.success("string")).eraseToAnyPublisher()
    }
}
