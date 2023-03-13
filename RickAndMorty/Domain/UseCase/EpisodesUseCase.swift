import Foundation
import Combine

struct EpisodesUseCase: EpisodesProtocol {
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func execute(character: Character) -> AnyPublisher<[Episode], Failure> {
        let episodes: String = character.episodeId.compactMap { $0.components(separatedBy: "/").last }.joined(separator: ",") + ","
        return repository.getEpisodes(episodeId: episodes)
    }
}
