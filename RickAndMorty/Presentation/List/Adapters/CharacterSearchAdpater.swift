//
//  CharacterSearchAdpater.swift
//  RickAndMorty
//
//  Created by Félix Luján on 14/3/23.
//

import UIKit

protocol CharacterSearchAdapterDelegate {
    func setSearchBar(_ searchBar: UISearchBar)
}

class CharacterSearchAdapter: NSObject, CharacterSearchAdapterDelegate {
    
    private weak var controller: CharacterListViewControllerDelegate?
    
    init(controller: CharacterListViewControllerDelegate) {
        self.controller = controller
    }
    
    func setSearchBar(_ searchBar: UISearchBar) {
        searchBar.delegate = self
    }
}

extension CharacterSearchAdapter: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        controller?.didFilterWithResult(searchText)
    }
}
