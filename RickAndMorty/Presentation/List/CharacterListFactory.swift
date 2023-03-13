import Foundation

struct CharacterListFactory {
    static func makeCharactersUseCase() -> CharactersUseCase {
        CharactersUseCase(repository: makeRepository())
    }
}
