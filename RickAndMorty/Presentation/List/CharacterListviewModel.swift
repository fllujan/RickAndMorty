import Foundation
import Combine


class CharacterListviewModel: ViewModel {
    
    var event: Observable<Event<CharacterAndInfo>> = Observable(.loading)
    
    private let charactersUseCase: CharactersProtocol
    
    private var currentPage: Int = 0
    private var maxPage: Int = 1
    
    init(charactersUseCase: CharactersProtocol) {
        self.charactersUseCase = charactersUseCase
    }
    
    func loadMoreCharacters() {
        currentPage += 1
        guard currentPage <= maxPage else { return }
        
        event.value = .loading
        
        charactersUseCase.execute(next: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.event.value = .error(error: error)
                case .finished: break
                }
            } receiveValue: { [weak self] characterAndInfo in
                self?.maxPage = characterAndInfo.info.pages
                self?.event.value = .data(data: characterAndInfo)
            }
            .store(in: &cancellables)
    }

}
