import Combine

protocol CharacterListViewModelManager {
    var event: Published<Event<[Character]>>.Publisher { get }
    var searchDuplicate: Published<Bool>.Publisher { get }
    
    func loadMoreCharacters()
    func searchCharacters(_ searchText: String)
    func selectedCharacter(_ character: Character)
}

final class CharacterListViewModel: CharacterListViewModelManager {
    
    var event: Published<Event<[Character]>>.Publisher { $eventPublished }
    var searchDuplicate: Published<Bool>.Publisher { $searchDuplicatePublished }
    
    @Published private var eventPublished: Event<[Character]> = .loading
    @Published private var searchDuplicatePublished: Bool = false
    
    private let searchText = CurrentValueSubject<String, Failure>("")
    private let charactersUseCase: CharactersUseCase
    private let searchCharactersUseCase: SearchCharactersUseCase
    private let viewsCoordinator: ViewsCoordinatorManager
    private var currentPage: Int = 0
    private var maxPage: Int = 1
    
    init(charactersUseCase: CharactersUseCase,
         searchCharactersUseCase: SearchCharactersUseCase, 
         viewsCoordinator: ViewsCoordinatorManager
    ) {
        self.charactersUseCase = charactersUseCase
        self.searchCharactersUseCase = searchCharactersUseCase
        self.viewsCoordinator = viewsCoordinator
        observerSearch()
    }
    
    func loadMoreCharacters() {
        currentPage += 1
        guard currentPage <= maxPage else { return }
        
        eventPublished = .loading
        
        let params = ListCharacterParams(next: currentPage, searchText: searchText.value)
        charactersUseCase(params: params, onSuccess, onError)
    }
    
    func searchCharacters(_ searchText: String) {
        self.searchText.send(searchText)
    }
    
    func selectedCharacter(_ character: Character) {
        viewsCoordinator.goToDetailCharacter(character)
    }
    
    private func observerSearch() {
        searchCharactersUseCase(params: searchText, onSuccess, onError)
    }
    
    private func onSuccess(_ searchText: String) {
        searchDuplicatePublished = false
        currentPage = 0
        loadMoreCharacters()
    }
    
    private func onSuccess(_ characterAndInfo: CharacterAndInfo) {
        maxPage = characterAndInfo.info.pages
        eventPublished = .data(data: characterAndInfo.characters)
    }
    
    private func onError(_ error: Failure) {
        eventPublished = .error(error: error)
    }
}
