struct CharacterListFactory {
    static func makeCharactersUseCase() -> CharactersUseCase {
        CharactersUseCaseImpl(repository: Factory.shared.makeRepository())
    }
    
    static func makeSearchCharactersUseCase() -> SearchCharactersUseCase {
        SearchCharactersUseCaseImpl()
    }
}
