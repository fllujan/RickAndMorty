import Foundation
import Combine

class ViewModel {
    internal var cancellables: Set<AnyCancellable> = []
    
    deinit {
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
    }
}
