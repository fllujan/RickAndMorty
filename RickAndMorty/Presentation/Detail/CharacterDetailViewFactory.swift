struct CharacterDetailViewFactory {
    static func makeEpisodesUseCase() -> EpisodesUseCaseImpl {
        EpisodesUseCaseImpl(repository: Factory.shared.makeRepository())
    }
    
    static func makeCharacterDetailViewModel() -> CharacterDetailViewModel {
        CharacterDetailViewModel(episodesUseCase: makeEpisodesUseCase())
    }
}
