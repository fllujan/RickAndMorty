import XCTest

final class CharacaterDetailViewUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func test_when_tap_one_character_list_should_see_the_single_character() {
        app.launchArguments = ["mock"]
        app.launch()
        let element = app.collectionViews.children(matching: .cell).element(boundBy: 0)
        
        element.staticTexts["Rick Sanchez"].tap()
        let elementsQuery = app.scrollViews.otherElements
        
        
        XCTAssertTrue(elementsQuery.staticTexts["Rick Sanchez"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Male"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Human"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Earth"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Alive"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Genero"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Specie"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Origin"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Status"].exists)
        
        XCTAssertTrue(elementsQuery.staticTexts["Episodes"].exists)
        elementsQuery.staticTexts["Anatomy Park"].swipeUp()
        XCTAssertTrue(elementsQuery.staticTexts["S01E03"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["December 16, 2013"].exists)
        
    }
    
    func test_when_call_characters_and_result_error_should_see_the_error() {
        app.launchArguments = ["mock", "mockError"]
        app.launch()
        let element = app.collectionViews.children(matching: .cell).element(boundBy: 0)
        
        element.staticTexts["Rick Sanchez"].tap()
        
        XCTAssertTrue(app.staticTexts["Sorry, something went wrong. Please try again later or contact support."].exists)
        
    }
}
