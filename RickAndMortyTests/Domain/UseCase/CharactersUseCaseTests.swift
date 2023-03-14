import XCTest
@testable import RickAndMorty

final class CharactersUseCaseTests: XCTestCase {
    
    private var mockRepository: MockRepository!
    private var sut: CharactersUseCase!

    override func setUpWithError() throws {
        mockRepository = MockRepository()
        sut = CharactersUseCase(repository: mockRepository)
    }

    override func tearDownWithError() throws {
        mockRepository = nil
        sut = nil
    }
    
    func test_when_call_characters_repository_should_call_repository() {
        let _ = sut.execute(next: 1, searchText: "")
        
        XCTAssertTrue(mockRepository.repoCall)
        XCTAssertEqual(mockRepository.repoCount, 1)
    }
    
    func test_when_call_characters_should_return_characters() {
        let name = "Rick Sanche"
        let status = "Alive"
        let species = "Human"
        let pages = 42
        let next = "https://rickandmortyapi.com/api/character?page=2"
        
        let result = sut.execute(next: 1, searchText: "")
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertTrue(isData)
            XCTAssertFalse(isError)
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
    
    func test_when_call_characters_result_error_should_see_the_error() {
        mockRepository.repoError = true
        
        let result = sut.execute(next: 1, searchText: "")
        
        CheckCombine.with(result) { isError, isData in
            XCTAssertFalse(isData)
            XCTAssertTrue(isError)
        } onError: { error in
            XCTAssertEqual(error, .httpResponseError)
        }
    }
}
