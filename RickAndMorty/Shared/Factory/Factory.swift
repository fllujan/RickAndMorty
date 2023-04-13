import UIKit
import CoreData

final class Factory {
    
    static let shared = Factory()
    private var networkStatus: ConnectivityManager?
    private var dataBaseManager: DataBaseManager?
    
    private init() {}
    
    func makeRepository() -> Repository {
        #if DEBUG
            if CommandLine.arguments.contains("mock") {
                return MockRepository()
            }
        #endif
        
        return RepositoryImpl(remoteDataSource: makeRemoteDataSource(), localDataSource: makeLocalDataSource(), connectivity: makeConnectivity())
    }

    private func makeConnectivity() -> ConnectivityManager {
        if networkStatus == nil {
            networkStatus = NetworkStatus()
        }
        return networkStatus!
    }

    private func makeRemoteDataSource() -> RemoteDataSource {
        RemoteDataSourceImpl(api: makeApiURLSession())
    }

    private func makeLocalDataSource() -> LocalDataSource {
        LocalDataSourceImpl(dataBase: makeDataBase())
    }

    private func makeDataBase() -> DataBaseManager {
        if dataBaseManager == nil {
            lazy var persistentContainer: NSPersistentContainer = {
                let container = NSPersistentContainer(name: "CharacterCoreData")
                container.loadPersistentStores { _, error in
                    if let error = error as NSError? {
                        fatalError("The database could not be loaded, \(error)")
                    }
                }
                return container
            }()
            dataBaseManager = CoreDataBase(context: persistentContainer.newBackgroundContext())
        }
        return dataBaseManager!
    }

    private func makeApiURLSession() -> NetworkClient {
        UrlSessionNetworkClient()
    }
}


    
