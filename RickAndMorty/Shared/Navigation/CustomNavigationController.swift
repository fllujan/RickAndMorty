import UIKit

class CustomNavigationController: UINavigationController {
    
    private lazy var viewsCoordinator: ViewsCoordinatorManager = ViewsCoordinator(supportNavigation: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rootController = CharacterListViewController.buildWith(viewsCoordinator)
        self.viewControllers = [rootController]
    }
}
