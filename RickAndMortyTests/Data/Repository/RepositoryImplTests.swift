import XCTest
@testable import RickAndMorty

final class RepositoryImplTests: XCTestCase {
    
    private var mockRemoteDataSource: MockRemoteDataSourceImpl!
    private var sut: RepositoryImpl!

    override func setUpWithError() throws {
        mockRemoteDataSource = MockRemoteDataSourceImpl()
        sut = RepositoryImpl(remoteDataSource: mockRemoteDataSource)
    }

    override func tearDownWithError() throws {
        mockRemoteDataSource = nil
        sut = nil
    }

    func test_when_call_characters_by_remote_should_characters_and_info() {
        let name = "Rick Sanchez"
        let status = "Alive"
        let species = "Human"
        let count = 826
        let pages = 42
        
        let result = sut.getCharacters(next: 1)
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertTrue(isData)
            XCTAssertFalse(isError)
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
    
    func test_when_call_characters_by_remote_result_error_should_see_the_error() {
        mockRemoteDataSource.remoteError = true
    
        let result = sut.getCharacters(next: 1)
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertTrue(isError)
            XCTAssertFalse(isData)
        } onError: { error in
            XCTAssertEqual(error, .httpResponseError)
        }
    }
    
    func test_when_call_episodes_by_remote_should_episodes() {
        let name = "The Ricklantis Mixup"
        let air_date = "September 10, 2017"
        let episodeNumber = "S03E07"
        
        let result = sut.getEpisodes(episodeId: "1,2")
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertTrue(isData)
            XCTAssertFalse(isError)
        } onData: { episodes in
            let episode = episodes.first!
            
            XCTAssertEqual(episode.name, name)
            XCTAssertEqual(episode.airDate, air_date)
            XCTAssertEqual(episode.episodeNumber, episodeNumber)
            XCTAssertTrue(self.mockRemoteDataSource.remoteCall)
            XCTAssertEqual(self.mockRemoteDataSource.remoteCount, 1)
        }
    }
    
    func test_when_call_episodes_by_remote_result_error_should_see_the_error() {
        mockRemoteDataSource.remoteError = true
    
        let result = sut.getEpisodes(episodeId: "1,2")
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertTrue(isError)
            XCTAssertFalse(isData)
        } onError: { error in
            XCTAssertEqual(error, .httpResponseError)
        }
    }
}
