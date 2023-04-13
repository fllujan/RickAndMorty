import Combine

typealias CharactersUseCase = UseCase<ListCharacterParams, CharacterAndInfo>

final class CharactersUseCaseImpl: CharactersUseCase {
    
    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }
    
    override func run(params: ListCharacterParams) -> AnyPublisher<CharacterAndInfo, Failure> {
        repository.getCharacters(next: params.next, searchText: params.searchText)
    }
}

struct ListCharacterParams {
    let next: Int
    let searchText: String
}
