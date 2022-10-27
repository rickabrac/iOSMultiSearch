//
//  UIDummyTests.swift
//  MultiSearchUITests
//  Created by Rick Tyler
//
//  Recording experiment test dummy
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
				
		// Place cursor on next line, press red record button below to experiment
    }
}
