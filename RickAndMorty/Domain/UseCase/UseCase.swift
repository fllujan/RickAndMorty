import Foundation
import Combine

class UseCase<Params, Response> {
    
    private var cancellables: Set<AnyCancellable> = []
    
    func run(params: Params) -> AnyPublisher<Response, Failure> { fatalError("The method run not implement") }
    
    func callAsFunction(params: Params, _ onSuccess: @escaping (Response) -> Void, _ onError: @escaping (Failure) -> Void) {
        run(params: params)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    onError(error)
                case .finished: break
                }
            } receiveValue: { data in
                onSuccess(data)
            }
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
    }
}

struct NoParams {}
