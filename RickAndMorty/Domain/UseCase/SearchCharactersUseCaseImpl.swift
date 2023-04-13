import Foundation
import Combine

typealias SearchCharactersUseCase = UseCase<CurrentValueSubject<String, Failure>, String>

final class SearchCharactersUseCaseImpl: SearchCharactersUseCase {
        
    override func run(params: CurrentValueSubject<String, Failure>) -> AnyPublisher<String, Failure> {
        params
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
