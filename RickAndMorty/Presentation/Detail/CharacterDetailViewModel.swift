import SwiftUI

protocol CharacterDetailViewModelManager: ObservableObject {
    var event: Event<[Episode]> { get }
    func getEpisodes(character: Character)
}

final class CharacterDetailViewModel: CharacterDetailViewModelManager {
    
    @Published var event: Event<[Episode]> = .loading
    
    private let episodesUseCase: EpisodesUseCase
    
    init(episodesUseCase: EpisodesUseCase) {
        self.episodesUseCase = episodesUseCase
    }
    
    func getEpisodes(character: Character) {
        let params = EpisodesParams(character: character)
        episodesUseCase(params: params, onSuccess, onError)
    }
    
    private func onSuccess(_ episodes: [Episode]) {
        event = .data(data: episodes)
    }
    
    private func onError(_ error: Failure) {
        event = .error(error: error)
    }
}
