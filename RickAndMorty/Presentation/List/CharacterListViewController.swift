import UIKit
import Combine

protocol CharacterListViewControllerDelegate: AnyObject {
    func selectedCharacter(_ character: Character)
    func getMoreCharacters()
    func searchWithText(_ searchText: String)
}

final class CharacterListViewController: UIViewController {
    
    @IBOutlet private weak var displayCharacter: UICollectionView!
    
    private var cancellables: Set<AnyCancellable> = []
    private let searchCharacter = UISearchController(searchResultsController: nil)
    private let spinner = UIActivityIndicatorView()
    
    var viewModel: CharacterListViewModelManager?
    var listAdapter: CharacterListAdapterManager?
    var searchAdapter: CharacterSearchAdapterManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spinner)
        setupNavigation()
        setupAdapter()
        suscriptions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        spinner.frame = view.bounds
    }
    
    func setupNavigation() {
        navigationItem.searchController = searchCharacter
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupAdapter() {
        listAdapter?.setManagerView(displayCharacter)
        searchAdapter?.setManagerView(searchCharacter)
    }
    
    private func suscriptions() {
        viewModel?.event.sink { [weak self] event in
            switch event { 
            case .loading:
                self?.onLoading()
            case .error(let error):
                self?.onError(error)
            case .data(let characters):
                self?.onSuccess(characters)
            }
        }
        .store(in: &cancellables)
                        
        viewModel?.searchDuplicate.sink { [weak self] isDuplicate in
            switch isDuplicate {
            case false:
                self?.onInitSearch()
            default: break
            }
        }
        .store(in: &cancellables)
    }
    
    private func onLoading() {
        spinner.startAnimating()
    }
    
    private func onError(_ error: Failure) {
        spinner.stopAnimating()
        showAlertError(error)
        listAdapter?.checkCharacterNotFound()
    }
    
    private func onSuccess(_ characters: [Character]) {
        spinner.stopAnimating()
        listAdapter?.arrayData.append(contentsOf: characters)
        listAdapter?.checkCharacterNotFound()
    }
    
    private func onInitSearch() {
        spinner.startAnimating()
        listAdapter?.arrayData = []
    }
}

extension CharacterListViewController: CharacterListViewControllerDelegate {
    func getMoreCharacters() {
        viewModel?.loadMoreCharacters()
    }
    
    func selectedCharacter(_ character: Character) {
        viewModel?.selectedCharacter(character)
    }
    
    func searchWithText(_ searchText: String) {
        viewModel?.searchCharacters(searchText)
    }
}
