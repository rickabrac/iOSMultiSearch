//
//  BingViewControllerTests.swift
//  MultiSearchTests
//  Created by Rick Tyler
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import MultiSearch

class BingViewControllerTests: XCTestCase {
	var vc: UIViewController?
	var vm: BingViewModel?
	let light = UITraitCollection(userInterfaceStyle: UIUserInterfaceStyle.light)
	let dark = UITraitCollection(userInterfaceStyle: UIUserInterfaceStyle.dark)
	
	override func setUpWithError() throws {
		vm = BingViewModel(api: BingAPI(cannedResponseFileName: "BingStubResult"))
		guard let vm = vm else {
			XCTAssert(false)
			return
		}
		let uiView = BingUIView(viewModel: vm)
		vc = UIHostingController(rootView: uiView)
		vm.search("?")
		sleep(2)
	}
	
	func testBingViewControllerLight() throws {
		guard let vc = vc else {
			XCTAssert(false)
			return
		}
		assertSnapshot(matching: vc, as: .image(on: .iPhoneX, traits: light))
	}
	
	func testBingViewControllerDark() throws {
		guard let vc = vc else {
			XCTAssert(false)
			return
		}
		assertSnapshot(matching: vc, as: .image(on: .iPhoneX, traits: dark))
	}
	
	func testBingViewControllerNoResultLight() throws {
		let vm = BingViewModel(api: BingAPI())
		let uiView = BingUIView(viewModel: vm)
		vc = UIHostingController(rootView: uiView)
		vm.search("avdoihertoihefgafdg")
		sleep(2)
		assertSnapshot(matching: vc!, as: .image(on: .iPhoneX, traits: light))
	}
	
	func testBingViewControllerNoResultDark() throws {
		let vm = BingViewModel(api: BingAPI())
		let uiView = BingUIView(viewModel: vm)
		vc = UIHostingController(rootView: uiView)
		vm.search("lkjasdfkjasdflkajsdfalkf")
		sleep(2)
		assertSnapshot(matching: vc!, as: .image(on: .iPhoneX, traits: dark))
	}
	
	func testBingViewControllerNoResultLightSpanish() throws {
		let vm = BingViewModel(api: BingAPI())
		let uiView = BingUIView(viewModel: vm)
		vc = UIHostingController(rootView: uiView)
		vm.search("lkjasdfkjasdflkajsdfalkf")
		sleep(2)
		assertSnapshot(matching: vc!, as: .image(on: .iPhoneX, traits: light))
	}
	
	func testBingViewControllerNoResultDarkSpanish() throws {
		let vm = BingViewModel(api: BingAPI())
		let uiView = BingUIView(viewModel: vm)
		vc = UIHostingController(rootView: uiView)
		vm.search("lkjasdfkjasdflkajsdfalkf")
		sleep(2)
		assertSnapshot(matching: vc!, as: .image(on: .iPhoneX, traits: dark))
	}
}
