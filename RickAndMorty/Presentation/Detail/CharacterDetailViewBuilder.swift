extension CharacterDetailView<CharacterDetailViewModel> {
    
    static func buildWith(_ character: Character) -> CharacterDetailView<CharacterDetailViewModel> {
        CharacterDetailView(viewModel: CharacterDetailViewFactory.makeCharacterDetailViewModel(), character: character)
    }
}
