import Foundation
import Combine

class ViewModel {
    lazy var cancellables: Set<AnyCancellable> = []
    
    deinit {
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
    }
}
