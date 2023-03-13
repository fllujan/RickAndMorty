import Foundation
import Combine

struct CharactersUseCase: CharactersProtocol {
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func execute(next: Int) -> AnyPublisher<CharacterAndInfo, Failure> {
        repository.getCharacters(next: next)
    }
}
