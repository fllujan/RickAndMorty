import Foundation


enum Event<T> {
    case loading, error(error: Failure), data(data: T)
}
