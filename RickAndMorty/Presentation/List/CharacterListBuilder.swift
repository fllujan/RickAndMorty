import UIKit


extension CharacterListViewController {
    
    class fileprivate var storyboardIdentifier: String { "CharacterListViewController" }
    
    class func build() -> CharacterListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? CharacterListViewController else { return CharacterListViewController() }

        controller.title = "Characters"
        
        controller.viewModel = CharacterListviewModel(charactersUseCase: CharacterListFactory.makeCharactersUseCase())
        controller.listAdapter = CharacterListAdapter(controller: controller)
        controller.searchAdpater = CharacterSearchAdapter(controller: controller)
        
        return controller
    }
}
