import UIKit
import SwiftUI
import Combine

protocol CharacterListViewControllerDelegate: NSObjectProtocol {
    func goToDetail(_ character: Character)
    func getMoreCharacters()
    func didFilterWithResult(_ searchText: String)
}

class CharacterListViewController: UIViewController {
    
    @IBOutlet private weak var clvCharacter: UICollectionView!
    @IBOutlet private weak var srBCharacter: UISearchBar!
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    var viewModel: CharacterListviewModel?
    var listAdapter: CharacterListApapterDelegate?
    var searchAdpater: CharacterSearchAdapterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spinner)
        suscriptions()
        setupAdapter()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        spinner.frame = view.bounds
    }
    
    func setupAdapter() {
        listAdapter?.setCollectionView(clvCharacter)
        searchAdpater?.setSearchBar(srBCharacter)
    }
    
    private func suscriptions() {
        viewModel?.$event.sink { [weak self] event in
            switch event {
            case .loading:
                self?.spinner.startAnimating()
            case .error(let error):
                print(error)
                self?.spinner.stopAnimating()
            case .data(let data):
                self?.spinner.stopAnimating()
                self?.listAdapter?.arrayData.append(contentsOf: data.characters)
                self?.listAdapter?.reload = true
                self?.clvCharacter.reloadData()
            }
        }
        .store(in: &cancellables)
    }
}

extension CharacterListViewController: CharacterListViewControllerDelegate {
    func getMoreCharacters() {
        listAdapter?.reload = false
        viewModel?.loadMoreCharacters()
    }
    
    func goToDetail(_ character: Character) {
        let controller = UIHostingController(rootView: CharacterDetailView.build(character: character))
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didFilterWithResult(_ searchText: String) {
        listAdapter?.arrayData = []
        viewModel?.searchCharacters(searchText)
    }
}
