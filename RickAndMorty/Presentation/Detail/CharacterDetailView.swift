import SwiftUI

struct CharacterDetailView<ViewModel: CharacterDetailViewModelManager>: View {
    
    @StateObject private var viewModel: ViewModel
    private var character: Character
    
    init(viewModel: ViewModel, character: Character) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.character = character
        viewModel.getEpisodes(character: character)
    }
    
    var body: some View {
        switch viewModel.event {
        case .loading:
            ProgressView().scaleEffect(1.2)
        case .data(let episodes):
            DetailView(character: character, episodes: episodes)
        case .error(let error):
            ErrorView(error: error)
        }
    }
}

#if DEBUG
struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView.buildWith(MockCharacterDetailView.mockCharacter())
    }
}
#endif
