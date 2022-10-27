//
//  MultiSearchUITests.swift
//  MultiSearchUITests
//  Created by Rick Tyler
//

import XCTest
@testable import MultiSearch

class MultiSearchUITests: XCTestCase {

    override func setUpWithError() throws {
		try super.setUpWithError()
        continueAfterFailure = false
    }

    func testMultiSearchUI() throws {
		let app = XCUIApplication()
		app.launchArguments = ["UITestingMode"]
		app.launch()
		
		// DuckDuckGo

		XCTAssert(app.staticTexts["DuckDuckGo"].exists)

		let ddgElement = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
		let ddgTextField = ddgElement.children(matching: .textField).element
		ddgTextField.tap()
		ddgTextField.typeText("test")
		
		app.buttons["Return"].tap()
		
		sleep(3)

		let ddgTableView = app.tables.matching(identifier: "DuckDuckGoSearchTableView")
		let ddgResultItem = ddgTableView.staticTexts["Test (wrestler) A Canadian professional wrestler and actor."]
		XCTAssert(ddgResultItem.exists)
		
		// Google

		let tabBar = app.tabBars["Tab Bar"]
		
		tabBar.buttons["Google"].tap()
		XCTAssert(app.staticTexts["Google"].exists)

		let googleElement = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
		let googleTextField = googleElement.children(matching: .textField).element
		googleTextField.tap()
		googleTextField.typeText("parrot")
		
		app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
		
		sleep(3)
		
		let googleTableView = app.tables.matching(identifier: "GoogleSearchTableView")
		let googleResultItem = googleTableView.staticTexts["The all-in-one platform for remote depositions. Reliable and remarkably easy."]
		XCTAssert(googleResultItem.exists)
		
		// Bing
		
		tabBar.buttons["Bing"].tap()
		XCTAssert(app.staticTexts["Bing"].exists)
		
		let bingTextField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element
		bingTextField.tap()
		bingTextField.typeText("catatonic")

		app.buttons["Return"].tap()
		
		sleep(3)
		
		let bingTableView = app.tables["BingTableView"]
		let bingResultItem = bingTableView.cells["catatonic: [adjective] of, relating to, marked by, or affected with catatonia."]
		XCTAssert(bingResultItem.exists)
	}
}
