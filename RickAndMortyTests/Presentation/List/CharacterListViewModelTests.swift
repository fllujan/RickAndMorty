import XCTest
import Combine
@testable import RickAndMorty

final class CharacterListViewModelTests: XCTestCase {
    
    private var isLoading: Bool = false
    private var isData: Bool = false
    private var isError: Bool = false
    
    private var mockCharactersUseCase: MockCharactersUseCase!
    private var sut: CharacterListviewModel!
    
    override func setUpWithError() throws {
        mockCharactersUseCase = MockCharactersUseCase()
        
        sut = CharacterListviewModel(charactersUseCase: mockCharactersUseCase)
    }

    override func tearDownWithError() throws {
        mockCharactersUseCase = nil
        sut = nil
    }

    func test_when_call_list_characters_should_call_all_use_case()  {
        sut.loadMoreCharacters()
        
        XCTAssertTrue(mockCharactersUseCase.isCall)
        XCTAssertEqual(mockCharactersUseCase.countCall, 1)
    }
    
    func test_when_list_characters_should_return_characters_and_info() {
        let name = "Rick Sanche"
        let status = "Alive"
        let species = "Human"
        let pages = 42
        let next = "https://rickandmortyapi.com/api/character?page=2"
        
        sut.loadMoreCharacters()
        
        checkEvent {
            XCTAssertTrue(self.isData)
            XCTAssertFalse(self.isError)
        } onData: { characterAndInfo in
            let character = characterAndInfo.characters.first!
            let info = characterAndInfo.info
            
            XCTAssertEqual(character.name, name)
            XCTAssertEqual(character.status, status)
            XCTAssertEqual(character.species, species)
            XCTAssertEqual(info.pages, pages)
            XCTAssertEqual(info.next, next)
        }
    }
    
    func test_when_call_characters_and_result_error_characters_should_see_the_error() {
        mockCharactersUseCase.isError = true
        
        sut.loadMoreCharacters()
        
        checkEvent {
            XCTAssertTrue(self.isLoading)
            XCTAssertFalse(self.isData)
        }  onError: { error in
            XCTAssertEqual(error, .httpResponseError)
        }

    }
}


extension CharacterListViewModelTests {
    
    private func checkEvent(onLoading: @escaping () -> Void, onData: ((CharacterAndInfo) -> Void)? = nil, onError: ((Failure?) -> Void)? = nil) {
        let exp = expectation(description: "waiting")
        sut.event.observer { event in
            switch event {
            case .loading:
                self.isLoading = true
            case .data(data: let data):
                self.isData = true
                onData?(data)
                exp.fulfill()
            case .error(error: let error):
                self.isError = true
                onError?(error)
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 1)
    }
}
