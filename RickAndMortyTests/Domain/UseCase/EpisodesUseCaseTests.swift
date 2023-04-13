import XCTest
@testable import RickAndMorty

final class EpisodesUseCaseTests: XCTestCase {

    private var mockRepository: MockRepository!
    private var sut: EpisodesUseCaseImpl!

    override func setUpWithError() throws {
        mockRepository = MockRepository()
        sut = EpisodesUseCaseImpl(repository: mockRepository)
    }

    override func tearDownWithError() throws {
        mockRepository = nil
        sut = nil
    }
    
    func test_when_call_episodes_repository_should_call_repository() {
        let _ = sut.run(params: EpisodesParams(character: MockCharacter.anCharacter()))
        
        XCTAssertTrue(mockRepository.repoCall)
        XCTAssertEqual(mockRepository.repoCount, 1)
    }
    
    func test_when_call_episodes_should_return_episodes() {
        let id = 1
        let name = "Pilot"
        let airDate = "December 2, 2013"
        let episodeNumber = "S01E01"
        
        let result = sut.run(params: EpisodesParams(character: MockCharacter.anCharacter()))
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertTrue(isData)
            XCTAssertFalse(isError)
        } onData: { episodes in
            let episode = episodes.first!
            
            XCTAssertEqual(episode.id, id)
            XCTAssertEqual(episode.name, name)
            XCTAssertEqual(episode.airDate, airDate)
            XCTAssertEqual(episode.episodeNumber, episodeNumber)
        }
    }
    
    func test_when_call_episodes_result_error_should_see_the_error() {
        mockRepository.repoError = true
        
        let result = sut.run(params: EpisodesParams(character: MockCharacter.anCharacter()))
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertFalse(isData)
            XCTAssertTrue(isError)
        } onError: { error in
            XCTAssertEqual(error, .httpResponseError)
        }
    }

}
