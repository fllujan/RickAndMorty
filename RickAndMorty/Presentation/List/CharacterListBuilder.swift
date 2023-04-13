import UIKit

extension CharacterListViewController {
    
    class fileprivate var storyboardIdentifier: String { "CharacterListViewController" }
    
    class func buildWith(_ viewsCoordinator: ViewsCoordinatorManager) -> CharacterListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? CharacterListViewController else { return CharacterListViewController() }

        controller.title = "characters".localized()
        
        controller.viewModel = CharacterListViewModel(charactersUseCase: CharacterListFactory.makeCharactersUseCase(),
                                                      searchCharactersUseCase: CharacterListFactory.makeSearchCharactersUseCase(),
                                                      viewsCoordinator: viewsCoordinator)
        
        controller.listAdapter = CharacterListAdapter(delegate: controller)
        controller.searchAdapter = CharacterSearchAdapter(delegate: controller)
        
        return controller
    }
}
