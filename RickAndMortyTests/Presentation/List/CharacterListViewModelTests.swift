import XCTest
import Combine
@testable import RickAndMorty

final class CharacterListViewModelTests: XCTestCase {
    
    private var mockCharactersUseCase: MockCharactersUseCase!
    private var mockSearchCharacterUseCase: MockSearchCharacterUseCase!
    private var mockViewsCoordinator: MockViewsCoordinator!
    private var sut: CharacterListViewModel!
    
    override func setUpWithError() throws {
        mockCharactersUseCase = MockCharactersUseCase()
        mockSearchCharacterUseCase = MockSearchCharacterUseCase()
        mockViewsCoordinator = MockViewsCoordinator()
        
        sut = CharacterListViewModel(charactersUseCase: mockCharactersUseCase,
                                     searchCharactersUseCase: mockSearchCharacterUseCase,
                                     viewsCoordinator: mockViewsCoordinator)
    }

    override func tearDownWithError() throws {
        mockCharactersUseCase = nil
        mockSearchCharacterUseCase = nil
        mockViewsCoordinator = nil
        sut = nil
    }
    
    func test_when_selected_character_should_go_to_detail_character() {
        sut.selectedCharacter(MockCharacter.anCharacter())
        
        XCTAssertTrue(mockViewsCoordinator.isCall)
        XCTAssertEqual(mockViewsCoordinator.countCall, 1)
    }

    func test_when_call_list_characters_should_call_all_use_case()  {
        sut.loadMoreCharacters()
        
        XCTAssertTrue(mockCharactersUseCase.isCall)
        XCTAssertEqual(mockCharactersUseCase.countCall, 1)
    }
    
    func test_when_list_characters_should_return_characters_and_info() {
        sut.loadMoreCharacters()
        
        checkEventCharacters()
    }
    
    func test_when_call_characters_and_result_error_characters_should_see_the_error() {
        mockCharactersUseCase.isError = true
        
        sut.loadMoreCharacters()
        
        CheckPublisher.with(sut.event) { isLoading in
            XCTAssertTrue(isLoading)
        } onData: { data in
            XCTAssertNil(data)
        } onError: { error in
            XCTAssertEqual(error, .httpResponseError)
        }
    }
    
    func test_when_search_characters_should_return_characters() {
        sut.searchCharacters("Rick Sanche")
        
        checkEventCharacters()
    }
    
    private func checkEventCharacters() {
        CheckPublisher.with(sut.event) { isLoading in
            XCTAssertTrue(isLoading)
        } onData: { characters in
            let character = characters.first!
            
            XCTAssertEqual(character.name, "Rick Sanche")
            XCTAssertEqual(character.status, "Alive")
            XCTAssertEqual(character.species, "Human")
        } onError: { error in
            XCTAssertNil(error)
        }
    }
}
