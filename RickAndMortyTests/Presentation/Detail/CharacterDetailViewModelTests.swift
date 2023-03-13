import XCTest
import Combine
@testable import RickAndMorty

final class CharacterDetailViewModelTests: XCTestCase {
    private var isLoading: Bool = false
    private var isData: Bool = false
    private var isError: Bool = false
    
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
        
        checkEvent {
            XCTAssertTrue(self.isData)
            XCTAssertFalse(self.isError)
        } onData: { episodes in
            let episode = episodes.first!
            
            XCTAssertEqual(episode.id, id)
            XCTAssertEqual(episode.name, name)
            XCTAssertEqual(episode.airDate, airDate)
            XCTAssertEqual(episode.episodeNumber, episodeNumber)
        }
    }
    
    func test_when_call_characters_and_result_error_characters_should_see_the_error() {
        mockEpisodesUseCase.isError = true
        
        sut.getEpisodes(character: MockCharacter.anCharacter())
        
        checkEvent {
            XCTAssertTrue(self.isLoading)
            XCTAssertFalse(self.isData)
        }  onError: { error in
            XCTAssertEqual(error, .httpResponseError)
        }

    }

}

extension CharacterDetailViewModelTests {

    private func checkEvent(onLoading: @escaping () -> Void, onData: (([Episode]) -> Void)? = nil, onError: ((Failure?) -> Void)? = nil) {
        let exp = expectation(description: "waiting")
        
        let cancellable = sut.$event.sink { event in
            switch event {
            case .loading:
                self.isLoading = true
            case .error(let error):
                self.isError = true
                onError?(error)
                exp.fulfill()
            case .data(let data):
                self.isData = true
                onData?(data)
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 1)
        cancellable.cancel()
    }
}
