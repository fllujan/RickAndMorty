import UIKit


class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rootController = CharacterListViewController.build()
        self.viewControllers = [rootController]
    }
}
