//
//  GoogleViewControllerTests.swift
//  MultiSearchTests
//  Created by Rick Tyler
//

import XCTest
import SnapshotTesting
@testable import MultiSearch

class GoogleViewControllerTests: XCTestCase {
	var vc: GoogleViewController? = nil
	var vm: GoogleViewModel? = nil
	let light = UITraitCollection(userInterfaceStyle: UIUserInterfaceStyle.light)
	let dark = UITraitCollection(userInterfaceStyle: UIUserInterfaceStyle.dark)
	
	override func setUpWithError() throws {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		vc = storyboard.instantiateViewController(withIdentifier: "GoogleViewController") as? GoogleViewController
		vm = GoogleViewModel(api: GoogleAPI(cannedResponseFileName: "GoogleStubResult"))
		guard let vc = vc, let vm = vm else {
			XCTAssert(false)
			return
		}
		vc.viewModel = vm
		vm.search("?")
		sleep(2)
	}
	
	func testGoogleResultLight() throws {
		guard let vc = vc else {
			XCTAssert(false)
			return
		}
		vc.overrideUserInterfaceStyle = .light
		assertSnapshot(matching: vc, as: .image(on: .iPhoneX, traits: light))
	}
	
	func testGoogleResultDark() throws {
		guard let vc = vc else {
			XCTAssert(false)
			return
		}
		vc.overrideUserInterfaceStyle = .dark
		assertSnapshot(matching: vc, as: .image(on: .iPhoneX, traits: dark))
	}
	
	func testGoogleNoResultLight() throws {
		guard let vc = vc else {
			XCTAssert(false)
			return
		}
		vc.overrideUserInterfaceStyle = .light
		vc.viewModel = nil
		vc.view.bringSubviewToFront(vc.noResults)
		assertSnapshot(matching: vc, as: .image(on: .iPhoneX, traits: light))
	}
	
	func testGoogleNoResultDark() throws {
		guard let vc = vc else {
			XCTAssert(false)
			return
		}
		vc.overrideUserInterfaceStyle = .dark
		vc.viewModel = nil
		vc.view.bringSubviewToFront(vc.noResults)
		assertSnapshot(matching: vc, as: .image(on: .iPhoneX, traits: dark))
	}
	
	func testGoogleNoResultLightSpanish() throws {
		guard let vc = vc else {
			XCTAssert(false)
			return
		}
		vc.overrideUserInterfaceStyle = .light
		vc.viewModel = nil
		vc.view.bringSubviewToFront(vc.noResults)
		assertSnapshot(matching: vc, as: .image(on: .iPhoneX, traits: light))
	}
	
	func testGoogleNoResultDarkSpanish() throws {
		guard let vc = vc else {
			XCTAssert(false)
			return
		}
		vc.overrideUserInterfaceStyle = .dark
		vc.viewModel = nil
		vc.view.bringSubviewToFront(vc.noResults)
		assertSnapshot(matching: vc, as: .image(on: .iPhoneX, traits: dark))
	}
}
