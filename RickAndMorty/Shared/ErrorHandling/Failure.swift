import Foundation

enum Failure: Error, LocalizedError {
    case generic
    case jsonDecoder
    case couldNotDecodeData
    case httpResponseError
    case statusCodeError
    case dbError
    case noFound
    
    var errorDescription: String? {
        switch self {
        case .generic,
                .couldNotDecodeData,
                .httpResponseError,
                .statusCodeError,
                .jsonDecoder,
                .dbError:
            return "error_generic".localized()
        case .noFound:
            return nil
        }
    }
}
