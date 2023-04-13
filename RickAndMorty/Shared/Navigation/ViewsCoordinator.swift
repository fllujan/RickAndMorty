import UIKit
import SwiftUI

protocol ViewsCoordinatorManager {
    func goToDetailCharacter(_ character: Character)
}

final class ViewsCoordinator: ViewsCoordinatorManager {
    
    private var supportNavigation: UINavigationController
    
    init(supportNavigation: UINavigationController) {
        self.supportNavigation = supportNavigation
    }
    
    func goToDetailCharacter(_ character: Character) {
        let controller = UIHostingController(rootView: CharacterDetailView.buildWith(character))
        supportNavigation.pushViewController(controller, animated: true)
    }
}
