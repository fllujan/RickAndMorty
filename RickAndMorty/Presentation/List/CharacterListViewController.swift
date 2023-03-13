import UIKit
import SwiftUI

protocol CharacterListViewControllerProtrocol: NSObjectProtocol {
    func goToDetail(_ character: Character)
    func getMoreCharacters()
}

class CharacterListViewController: UIViewController {
    
    @IBOutlet private weak var clvCharacter: UICollectionView!
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    var viewModel: CharacterListviewModel?
    var listAdapter: CharacterListApapterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spinner)
        suscriptions()
        setupAdapter()
        getMoreCharacters()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        spinner.frame = view.bounds
    }
    
    func setupAdapter() {
        self.listAdapter?.setCollectionView(clvCharacter)
    }
    
    private func suscriptions() {
        viewModel?.event.observer { [weak self] event in
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
    }
}

extension CharacterListViewController: CharacterListViewControllerProtrocol {
    func getMoreCharacters() {
        listAdapter?.reload = false
        self.viewModel?.loadMoreCharacters()
    }
    
    func goToDetail(_ character: Character) {
        let controller = UIHostingController(rootView: CharacterDetailView.build(character: character))
        navigationController?.pushViewController(controller, animated: true)
    }
}
