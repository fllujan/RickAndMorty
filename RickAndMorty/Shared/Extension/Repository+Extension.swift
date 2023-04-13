import Combine

extension Repository {
    
     func handleResult<T, R>(future: Future<T, Failure>, transform: @escaping (T) -> R, saveLocal: ((R) -> Void)? = nil) -> AnyPublisher<R, Failure> {
        return future.compactMap {
            let data = transform($0)
            saveLocal?(data)
            return data
        }
        .eraseToAnyPublisher()
    }
}
