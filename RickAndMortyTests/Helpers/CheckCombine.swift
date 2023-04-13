import XCTest
import Combine
@testable import RickAndMorty

struct CheckCombine {
    
    static func with<T: Publisher>(
        _ result: T,
        onFinish: @escaping (_ isError: Bool, _ isData: Bool) -> Void,
        onData: ((T.Output) -> Void)? = nil,
        onError: ((T.Failure) -> Void)? = nil
    ) {
        var isError: Bool = false
        var isData: Bool = false
        
        let exp = XCTestExpectation(description: "waiting")
        let cancellable = result.sink { completion in
            switch completion {
            case .failure(let error):
                isError = true
                onError?(error)
                onFinish(isError, isData)
                exp.fulfill()
            case .finished:
                onFinish(isError, isData)
                exp.fulfill()
            }
        } receiveValue: { data in
            isData = true
            onData?(data)
            exp.fulfill()
        }
        let _ = XCTWaiter.wait(for: [exp], timeout: 1)
        cancellable.cancel()
    }
}
