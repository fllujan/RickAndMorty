import XCTest
@testable import RickAndMorty

final class RemoteDataSourceImplTests: XCTestCase {
    
    private var mockApiURLSession: MockApiUrlSession!
    private var sut: RemoteDataSourceImpl!

    override func setUpWithError() throws {
        mockApiURLSession = MockApiUrlSession()
        sut = RemoteDataSourceImpl(api: mockApiURLSession)
    }

    override func tearDownWithError() throws {
        mockApiURLSession = nil
        sut = nil
    }
    
    func test_when_call_characters_should_return_characterDto() {
        mockApiURLSession.nameJson = "MockCharacters"
        let id = 1
        let name = "Rick Sanchez"
        let status = "Alive"
        let species = "Human"
        let gender = "Male"
        let count = 826
        let pages = 42
        
        let result = sut.getCharacters(next: 1, searchText: "")
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertTrue(isData)
            XCTAssertFalse(isError)
        } onData: { characterDto in
            let character = characterDto.results.first!
            let info = characterDto.info
            
            XCTAssertEqual(character.id, id)
            XCTAssertEqual(character.name, name)
            XCTAssertEqual(character.status, status)
            XCTAssertEqual(character.species, species)
            XCTAssertEqual(character.gender, gender)
            XCTAssertEqual(info.count, count)
            XCTAssertEqual(info.pages, pages)
            XCTAssertTrue(self.mockApiURLSession.apiCall)
            XCTAssertEqual(self.mockApiURLSession.apiCount, 1)
        }
    }
    
    func test_when_call_characters_and_result_error_should_see_the_error() {
        mockApiURLSession.apiError = true
        
        let result = sut.getCharacters(next: 1, searchText: "")
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertFalse(isData)
            XCTAssertTrue(isError)
        } onError: { error in
            XCTAssertEqual(error, .httpResponseError)
        }
    }
    
    func test_when_call_episodes_should_return_episodeDto() {
        mockApiURLSession.nameJson = "MockEpisodes"
        let id = 1
        let name = "Pilot"
        let air_date = "December 2, 2013"
        let episodeNumber = "S01E01"
        
        let result = sut.getEpisodes(episodeId: "1,2")
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertTrue(isData)
            XCTAssertFalse(isError)
        } onData: { episodeDto in
            let episode = episodeDto.first!
            
            XCTAssertEqual(episode.id, id)
            XCTAssertEqual(episode.name, name)
            XCTAssertEqual(episode.air_date, air_date)
            XCTAssertEqual(episode.episode, episodeNumber)
            XCTAssertTrue(self.mockApiURLSession.apiCall)
            XCTAssertEqual(self.mockApiURLSession.apiCount, 1)
        }
    }
    
    func test_when_call_episodes_and_result_error_should_see_the_error() {
        mockApiURLSession.apiError = true
        
        let result = sut.getEpisodes(episodeId: "1,2")
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertFalse(isData)
            XCTAssertTrue(isError)
        } onError: { error in
            XCTAssertEqual(error, .httpResponseError)
        }
    }

}
