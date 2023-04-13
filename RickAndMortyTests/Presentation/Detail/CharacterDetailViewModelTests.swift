import XCTest
import Combine
@testable import RickAndMorty

final class CharacterDetailViewModelTests: XCTestCase {
 
    private var mockEpisodesUseCase: MockEpisodesUseCase!
    private var sut: CharacterDetailViewModel!
    
    override func setUpWithError() throws {
        mockEpisodesUseCase = MockEpisodesUseCase()
        
        sut = CharacterDetailViewModel(episodesUseCase: mockEpisodesUseCase)
    }

    override func tearDownWithError() throws {
        mockEpisodesUseCase = nil
        sut = nil
    }
    
    func test_when_call_list_episodes_should_call_all_use_case()  {
        sut.getEpisodes(character: MockCharacter.anCharacter())
        
        XCTAssertTrue(mockEpisodesUseCase.isCall)
        XCTAssertEqual(mockEpisodesUseCase.countCall, 1)
    }
    
    func test_when_list_characters_should_return_characters_and_info() {
        let id = 1
        let name = "Pilot"
        let airDate = "December 2, 2013"
        let episodeNumber = "S01E01"
        
        sut.getEpisodes(character: MockCharacter.anCharacter())
        
        CheckPublisher.with(sut.$event) { isLoading in
            XCTAssertTrue(isLoading)
        } onData: { episodes in
            let episode = episodes.first!
            
            XCTAssertEqual(episode.id, id)
            XCTAssertEqual(episode.name, name)
            XCTAssertEqual(episode.airDate, airDate)
            XCTAssertEqual(episode.episodeNumber, episodeNumber)
        } onError: { error in
            XCTAssertNil(error)
        }
    }
    
    func test_when_call_characters_and_result_error_characters_should_see_the_error() {
        mockEpisodesUseCase.isError = true
        
        sut.getEpisodes(character: MockCharacter.anCharacter())
        
        CheckPublisher.with(sut.$event) { isLoading in
            XCTAssertTrue(isLoading)
        } onData: { data in
            XCTAssertNil(data)
        } onError: { error in
            XCTAssertEqual(error, .httpResponseError)
        }
    }

}
