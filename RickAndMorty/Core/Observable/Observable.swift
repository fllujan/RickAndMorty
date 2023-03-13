import Foundation


final class Observable<T> {
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func observer(_ listener: @escaping (T) -> Void) {
        listener(value)
        self.listener = listener
    }
}