struct CharacterDetailViewFactory {
    
    static func makeEpisodesUseCase() -> EpisodesUseCase {
        EpisodesUseCase(repository: makeRepository())
    }
    
    static func makeCharacterDetailViewModel() -> CharacterDetailViewModel {
        CharacterDetailViewModel(episodesUseCase: makeEpisodesUseCase())
    }
}
