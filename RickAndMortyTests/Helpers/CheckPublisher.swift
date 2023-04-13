import XCTest
@testable import RickAndMorty

struct CheckPublisher {
   
    static func with<T>(
        _ events: Published<Event<T>>.Publisher,
        onLoading: @escaping (Bool) -> Void,
        onData: ((T) -> Void)? = nil,
        onError: ((Failure?) -> Void)? = nil
    ) {
        let exp = XCTestExpectation(description: "waiting")
        let cancellable = events.sink { event in
            switch event {
            case .loading:
                onLoading(true)
            case .data(let data):
                onData?(data)
                exp.fulfill()
            case .error(let error):
                onError?(error)
                exp.fulfill()
            }
        }
        
        let _ = XCTWaiter.wait(for: [exp], timeout: 1)
        cancellable.cancel()
    }
}
