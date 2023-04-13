import Network

final class NetworkStatus: ConnectivityManager {
    
    var isConnectedToNetwork: Bool = true
    private let monitor: NWPathMonitor = NWPathMonitor()

    init() {
        monitor.pathUpdateHandler = { [weak self] in self?.handleUpdate($0) }
        monitor.start(queue: DispatchQueue(label: "Monitor"))
    }

    private func handleUpdate(_ path: NWPath) {
        isConnectedToNetwork = path.status == .satisfied
    }
    
    deinit {
        monitor.cancel()
    }
}
