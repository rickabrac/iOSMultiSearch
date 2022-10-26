//
//  DummyUITests.swift
//  MultiSearchUITests
//  Created by Rick Tyler
//
//  Recording experimentation dummy
//

import XCTest
@testable import MultiSearch 

class UIDummyTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

	func testDummy() throws {
		let app = XCUIApplication()
		app.launchArguments = ["UITestingMode"]
		app.launch()
				
		// Use for recording experiements
    }
}
