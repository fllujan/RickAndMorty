import UIKit

protocol CharacterSearchAdapterManager {
    func setManagerView(_ searchController: UISearchController)
}

final class CharacterSearchAdapter: NSObject, CharacterSearchAdapterManager {
    
    private weak var delegate: CharacterListViewControllerDelegate?
    
    init(delegate: CharacterListViewControllerDelegate) {
        self.delegate = delegate
    }
    
    func setManagerView(_ searchController: UISearchController) {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
}

extension CharacterSearchAdapter: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchWithText(searchText.trim())
    }
}
