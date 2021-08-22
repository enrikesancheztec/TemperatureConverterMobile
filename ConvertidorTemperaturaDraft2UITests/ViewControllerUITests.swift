//
//  ViewControllerUITests.swift
//  ConvertidorTemperaturaDraft2UITests
//
//  Created by user193555 on 8/15/21.
//

import XCTest

class ViewControllerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConvertionCelsius0() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let celciusTextField = app.textFields["celsiusTextField"]
        let fahrenheitTextField = app.textFields["fahrenheitTextField"]
        celciusTextField.tap()
        celciusTextField.typeText("0")
        app/*@START_MENU_TOKEN@*/.staticTexts["Convertir"]/*[[".buttons[\"Convertir\"].staticTexts[\"Convertir\"]",".staticTexts[\"Convertir\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        print("Fahrenheit text field " + (fahrenheitTextField.value as! String))
        XCTAssertEqual(fahrenheitTextField.value as! String, "32.0")
    }

}
