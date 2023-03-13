import Foundation

func makeRepository() -> Repository {
    #if DEBUG
        if CommandLine.arguments.contains("mock") {
            return MockRepository()
        } 
    #endif
    
    return RepositoryImpl(remoteDataSource: makeRemoteDataSource())
}

func makeRemoteDataSource() -> RemoteDataSourceImpl {
    RemoteDataSourceImpl(api: makeApiURLSession())
}

func makeApiURLSession() -> ApiURLSession {
    ApiURLSession()
}
    
