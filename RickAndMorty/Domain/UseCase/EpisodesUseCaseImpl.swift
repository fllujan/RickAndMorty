import Combine

typealias EpisodesUseCase = UseCase<EpisodesParams, [Episode]>

final class EpisodesUseCaseImpl: EpisodesUseCase {
    
    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }
    
    override func run(params: EpisodesParams) -> AnyPublisher<[Episode], Failure> {
        return repository.getEpisodes(character: params.character)
    }
}

struct EpisodesParams {
    let character: Character
}
