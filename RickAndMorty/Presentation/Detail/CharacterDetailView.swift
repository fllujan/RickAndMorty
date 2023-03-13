import SwiftUI

struct CharacterDetailView: View {
    
    @StateObject private var viewModel: CharacterDetailViewModel
    private var character: Character
    
    init(viewModel: CharacterDetailViewModel, character: Character) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.character = character
    }
    
    var body: some View {
        NavigationView {
            switch viewModel.event {
            case .loading:
                LoadingView()
            case .data(let episodes):
                DetailView(character: character, episodes: episodes)
            case .error(let error):
                ErrorView(type: error)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("\(character.name)")
        .onAppear {
            viewModel.getEpisodes(character: character)
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CharacterDetailView.build(character: MockDetailView.mockCharacter())
        }
    }
}
