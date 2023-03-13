import XCTest

class CharacterListViewControllerUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchArguments = ["mock"]
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func test_when_initialize_the_view_should_show_the_list() {
        let element = app.collectionViews.cells.element(boundBy: 0)
        
        XCTAssertTrue(element.isEnabled)
    }
    
    func test_whet_move_the_list_should_move_the_collection() {
        let element = app.collectionViews.children(matching: .cell).element(boundBy: 0)
        let staticText  = element.staticTexts["Rick Sanchez"]
        
        element.swipeUp()
        element.swipeDown()
                
        XCTAssertTrue(staticText.exists)
    }
}
