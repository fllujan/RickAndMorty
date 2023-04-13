@testable import RickAndMorty

class MockConnectivityManager: ConnectivityManager {
    var isConnectedToNetwork: Bool = true
    
    
    func isNotConnectedToNetwork() {
        isConnectedToNetwork = false
    }
}
