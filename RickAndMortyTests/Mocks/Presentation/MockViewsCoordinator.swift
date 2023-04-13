@testable import RickAndMorty

final class MockViewsCoordinator: ViewsCoordinatorManager {
    
    var isCall: Bool = false
    var countCall: Int = 0
    
    func goToDetailCharacter(_ character: Character) {
        isCall = true
        countCall += 1
    }
}
