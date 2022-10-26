//
//  DuckDuckGoViewControllerTests.swift
//  MultiSearchTests
//  Created by Rick Tyler
//

import XCTest
import SnapshotTesting
@testable import MultiSearch

class DuckDuckGoViewControllerTests: XCTestCase {
	var vc: DuckDuckGoViewController! = nil
	var vm: DuckDuckGoViewModel! = nil
	let light = UITraitCollection(userInterfaceStyle: UIUserInterfaceStyle.light)
	let dark = UITraitCollection(userInterfaceStyle: UIUserInterfaceStyle.dark)
	
	override func setUpWithError() throws {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		vc = storyboard.instantiateViewController(withIdentifier: "DuckDuckGoViewController") as? DuckDuckGoViewController
		vm = DuckDuckGoViewModel(api: DuckDuckGoAPI(cannedResponseFileName: "DuckDuckGoStubResult"))
		guard let vc = vc, let vm = vm else {
			XCTAssert(false)
			return
		}
		vm.delegate = vc
		vc.viewModel = vm
		vm.search("?")
		sleep(2)
	}
	
	func testDuckDuckGoResultLight() throws {
		assertSnapshot(matching: vc, as: .image(on: .iPhoneX, traits: light))
	}
	
    func testDuckDuckGoResultDark() throws {
		assertSnapshot(matching: vc, as: .image(on: .iPhoneX, traits: dark))
    }
	
	func testDuckDuckGoNoResultLight() throws {
		guard let vc = vc else {
			XCTAssert(false)
			return
		}
		vc.viewModel = nil
		vc.view.bringSubviewToFront(vc.noResults)
		assertSnapshot(matching: vc, as: .image(on: .iPhoneX, traits: light))
	}
	
	func testDuckDuckGoNoResultDark() throws {
		guard let vc = vc else {
			XCTAssert(false)
			return
		}
		vc.viewModel = nil
		vc.view.bringSubviewToFront(vc.noResults)
		assertSnapshot(matching: vc, as: .image(on: .iPhoneX, traits: dark))
	}
	
	func testDuckDuckGoNoResultLightSpanish() throws {
		guard let vc = vc else {
			XCTAssert(false)
			return
		}
		vc.viewModel = nil
		vc.view.bringSubviewToFront(vc.noResults)
		assertSnapshot(matching: vc, as: .image(on: .iPhoneX, traits: light))
	}
	
	func testDuckDuckGoNoResultDarkSpanish() throws {
		guard let vc = vc else {
			XCTAssert(false)
			return
		}
		vc.viewModel = nil
		vc.view.bringSubviewToFront(vc.noResults)
		assertSnapshot(matching: vc, as: .image(on: .iPhoneX, traits: dark))
	}
}
