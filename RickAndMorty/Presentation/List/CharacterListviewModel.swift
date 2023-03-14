import Foundation
import Combine

class CharacterListviewModel {
    
    @Published private var searchText: String = ""
    @Published private (set) var event: Event<CharacterAndInfo> = .loading
        
    private var cancellables: Set<AnyCancellable> = []
    private let charactersUseCase: CharactersProtocol
    private var currentPage: Int = 0
    private var maxPage: Int = 1
    
    init(charactersUseCase: CharactersProtocol) {
        self.charactersUseCase = charactersUseCase
        self.observerSearch()
    }
    
    func loadMoreCharacters() {
        currentPage += 1
        guard currentPage <= maxPage else { return }
        
        event = .loading
        
        charactersUseCase.execute(next: currentPage, searchText: searchText)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.event = .error(error: error)
                case .finished: break
                }
            } receiveValue: { [weak self] characterAndInfo in
                self?.maxPage = characterAndInfo.info.pages
                self?.event = .data(data: characterAndInfo)
            }
            .store(in: &cancellables)
    }
    
    func searchCharacters(_ searchText: String) {
        self.searchText = searchText
    }
    
    private func observerSearch() {
        $searchText
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { (_) in
            } receiveValue: { [weak self] _ in
                self?.currentPage = 0
                self?.loadMoreCharacters()
            }.store(in: &cancellables)
    }
    
    deinit {
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
    }

}
