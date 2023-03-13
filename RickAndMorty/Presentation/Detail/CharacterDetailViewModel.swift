import SwiftUI

final class CharacterDetailViewModel: ViewModel, ObservableObject {
    
    @Published var event: Event<[Episode]> = .loading
    
    private let episodesUseCase: EpisodesProtocol
    
    init(episodesUseCase: EpisodesProtocol) {
        self.episodesUseCase = episodesUseCase
    }
    
    func getEpisodes(character: Character) {
        episodesUseCase.execute(character: character)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.event = .error(error: error)
                case .finished: break
                }
            } receiveValue: { [weak self] episodes in
                self?.event = .data(data: episodes)
            }
            .store(in: &cancellables)
    }
}
