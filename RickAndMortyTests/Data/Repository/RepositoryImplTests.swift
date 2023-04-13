import XCTest
@testable import RickAndMorty

final class RepositoryImplTests: XCTestCase {
    
    private var mockRemoteDataSource: MockRemoteDataSourceImpl!
    private var mockLocalDataSource: MockLocalDataSourceImpl!
    private var mockConnectivity: MockConnectivityManager!
    private var sut: RepositoryImpl!

    override func setUpWithError() throws {
        mockRemoteDataSource = MockRemoteDataSourceImpl()
        mockLocalDataSource = MockLocalDataSourceImpl()
        mockConnectivity = MockConnectivityManager()
        sut = RepositoryImpl(remoteDataSource: mockRemoteDataSource, localDataSource: mockLocalDataSource, connectivity: mockConnectivity)
    }

    override func tearDownWithError() throws {
        mockRemoteDataSource = nil
        mockLocalDataSource = nil
        mockConnectivity = nil
        sut = nil
    }

    func test_when_has_internet_call_characters_by_remote_should_characters_and_info() {
        let name = "Rick Sanchez"
        let status = "Alive"
        let species = "Human"
        let count = 826
        let pages = 42
        
        let result = sut.getCharacters(next: 1, searchText: "")
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertTrue(isData)
            XCTAssertFalse(isError)
            XCTAssertTrue(self.mockRemoteDataSource.remoteCall)
            XCTAssertEqual(self.mockRemoteDataSource.remoteCount, 1)
            XCTAssertTrue(self.mockLocalDataSource.localCall)
            XCTAssertEqual(self.mockLocalDataSource.localCount, 1)
        } onData: { characterAndInfo in
            let character = characterAndInfo.characters.first!
            let info = characterAndInfo.info
            
            XCTAssertEqual(character.name, name)
            XCTAssertEqual(character.status, status)
            XCTAssertEqual(character.species, species)
            XCTAssertEqual(info.count, count)
            XCTAssertEqual(info.pages, pages)
            XCTAssertTrue(self.mockRemoteDataSource.remoteCall)
            XCTAssertEqual(self.mockRemoteDataSource.remoteCount, 1)
        }
    }
    
    func test_when_has_internet_call_characters_by_remote_result_error_should_see_the_error() {
        mockRemoteDataSource.remoteError = true
    
        let result = sut.getCharacters(next: 1, searchText: "")
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertTrue(isError)
            XCTAssertFalse(isData)
            XCTAssertFalse(self.mockLocalDataSource.localCall)
            XCTAssertEqual(self.mockLocalDataSource.localCount, 0)
            XCTAssertTrue(self.mockRemoteDataSource.remoteCall)
            XCTAssertEqual(self.mockRemoteDataSource.remoteCount, 1)
        } onError: { error in
            XCTAssertEqual(error, .httpResponseError)
        }
    }
    
    func test_when_has_internet_call_episodes_by_remote_should_episodes() {
        let name = "The Ricklantis Mixup"
        let air_date = "September 10, 2017"
        let episodeNumber = "S03E07"
        
        let result = sut.getEpisodes(character: MockCharacter.anCharacter())
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertTrue(isData)
            XCTAssertFalse(isError)
            XCTAssertTrue(self.mockRemoteDataSource.remoteCall)
            XCTAssertEqual(self.mockRemoteDataSource.remoteCount, 1)
            XCTAssertTrue(self.mockLocalDataSource.localCall)
            XCTAssertEqual(self.mockLocalDataSource.localCount, 1)
        } onData: { episodes in
            let episode = episodes.first!
            
            XCTAssertEqual(episode.name, name)
            XCTAssertEqual(episode.airDate, air_date)
            XCTAssertEqual(episode.episodeNumber, episodeNumber)
            XCTAssertTrue(self.mockRemoteDataSource.remoteCall)
            XCTAssertEqual(self.mockRemoteDataSource.remoteCount, 1)
        }
    }
    
    func test_when_has_internet_call_episodes_by_remote_result_error_should_see_the_error() {
        mockRemoteDataSource.remoteError = true
    
        let result = sut.getEpisodes(character: MockCharacter.anCharacter())
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertTrue(isError)
            XCTAssertFalse(isData)
            XCTAssertFalse(self.mockLocalDataSource.localCall)
            XCTAssertEqual(self.mockLocalDataSource.localCount, 0)
            XCTAssertTrue(self.mockRemoteDataSource.remoteCall)
            XCTAssertEqual(self.mockRemoteDataSource.remoteCount, 1)
        } onError: { error in
            XCTAssertEqual(error, .httpResponseError)
        }
    }
    
    func test_when_has_not_internet_call_characters_should_return_the_database() {
        mockConnectivity.isNotConnectedToNetwork()
        
        let _ = sut.getCharacters(next: 1, searchText: "")
        
        XCTAssertFalse(mockRemoteDataSource.remoteCall)
        XCTAssertEqual(mockRemoteDataSource.remoteCount, 0)
        XCTAssertTrue(mockLocalDataSource.localCall)
        XCTAssertEqual(mockLocalDataSource.localCount, 1)
    }
    
    func test_when_has_not_internet_call_characters_should_return_error_the_database() {
        mockConnectivity.isNotConnectedToNetwork()
        mockLocalDataSource.localError = true
        
        let result = sut.getCharacters(next: 1, searchText: "")
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertTrue(isError)
            XCTAssertFalse(isData)
            XCTAssertFalse(self.mockRemoteDataSource.remoteCall)
            XCTAssertEqual(self.mockRemoteDataSource.remoteCount, 0)
            XCTAssertTrue(self.mockLocalDataSource.localCall)
            XCTAssertEqual(self.mockLocalDataSource.localCount, 1)
        } onError: { error in
            XCTAssertEqual(error, .dbError)
        }
    }
    
    func test_when_has_not_internet_call_episodes_should_return_the_database() {
        mockConnectivity.isNotConnectedToNetwork()
        
        let _ = sut.getEpisodes(character: MockCharacter.anCharacter())
        
        XCTAssertFalse(mockRemoteDataSource.remoteCall)
        XCTAssertEqual(mockRemoteDataSource.remoteCount, 0)
        XCTAssertTrue(mockLocalDataSource.localCall)
        XCTAssertEqual(mockLocalDataSource.localCount, 1)
    }
    
    func test_when_has_not_internet_call_episodes_should_return_error_the_database() {
        mockConnectivity.isNotConnectedToNetwork()
        mockLocalDataSource.localError = true
        
        let result = sut.getEpisodes(character: MockCharacter.anCharacter())
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertTrue(isError)
            XCTAssertFalse(isData)
            XCTAssertFalse(self.mockRemoteDataSource.remoteCall)
            XCTAssertEqual(self.mockRemoteDataSource.remoteCount, 0)
            XCTAssertTrue(self.mockLocalDataSource.localCall)
            XCTAssertEqual(self.mockLocalDataSource.localCount, 1)
        } onError: { error in
            XCTAssertEqual(error, .dbError)
        }
    }
}
