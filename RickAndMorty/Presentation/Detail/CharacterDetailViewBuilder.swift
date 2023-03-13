import Foundation

extension CharacterDetailView {
    static func build(character: Character) -> CharacterDetailView {
        return CharacterDetailView(viewModel: CharacterDetailViewFactory.makeCharacterDetailViewModel(),
                                   character: character)
    }
}
