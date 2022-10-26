//
//  BingViewModelTests.swift
//  MultiSearchTests
//  Created by Rick Tyler
//

import XCTest
@testable import MultiSearch

class BingViewModelTests: XCTestCase {

	func testBingViewModel() throws {
		let api = BingAPI(cannedResponseFileName: "BingStubResult")
		let vm = BingViewModel(api: api)
		
		vm.search("?")
		XCTAssert(vm.searchInProgress())
		sleep(2)
		XCTAssertFalse(vm.searchInProgress())
		
		guard let items = vm.items else {
			XCTAssert(false)
			return
		}
		
		XCTAssert(vm.numberOfRowsInSection(section: 0) == 8)
			
		for i in 0..<items.count {
			let indexPath = IndexPath(row: i, section: 0)
			XCTAssertEqual(stubUrls[i], vm.urlForRowAt(indexPath: indexPath))
			XCTAssertEqual(stubTexts[i], vm.textForRowAt(indexPath: indexPath))
		}
	}
	
	var stubUrls = [
		"https://www.merriam-webster.com/dictionary/quirk",
		"https://dictionary.cambridge.org/dictionary/english/quirk",
		"https://myheroacademia.fandom.com/wiki/Quirk",
		"https://www.quirkauto.com/",
		"https://www.quirk.money/",
		"https://store.boulevard.com/collections/quirk",
		"https://algassert.com/quirk",
		"https://www.quirkcars.com/"
	]
	
	var stubTexts = [
		"quirk: [noun] an abrupt twist or curve. a peculiar trait : idiosyncrasy. accident, vagary.",
		"quirk definition: 1. an unusual habit or part of someone's personality, or something that is strange and unexpected…. Learn more.",
		"Eijiro Kirishima's Quirk first manifesting as a child. A person's Quirk will normally manifest anytime before the age of four, sometimes even straight after birth, such was the case with Present Mic and the Luminescent Baby. Although, there are late bloomers who don't develop their power until a bit later in life; one such example is Tenko Shimura, who didn't develop his Quirk until he was five.",
		"Quirk Auto Group Maine. Searching for a new vehicle? Your search will be cut short once you visit our Quirk dealerships in Augusta, Bangor, Belfast, Portland, and Rockland. At our new and used dealerships, we have a great selection of vehicles ready to be test driven immediately with fresh, updated special offers on your favorite brands.",
		"Quirk is an agent of Plaid Financial Ltd., an authorised payment institution regulated by the Financial Conduct Authority under the Payment Services Regulations 2017 (Firm Reference Number: 804718). Plaid provides you with regulated account information services through Quirk as its agent.",
		"Quirk. At Boulevard Beverage Company, we celebrate eccentricity. Quirk Spiked & Sparkling seltzers are infinitely enjoyable, brimming with unpredictable individuality. With real fruit juice and clean, all-natural ingredients, these unique flavors are 1oo% guilt-free, and 1oo% delightful. Click here to learn more.",
		"Quirk is an open-source drag-and-drop quantum circuit simulator for exploring and understanding small quantum circuits.",
		"Quirk Cars is a dealership group located near MA. We're here to help with any automotive needs you may have. Don't forget to check out our used cars. Map MA Today 9-8pm New View all [2680] Ford [165] Chevrolet [619] Buick [24 ..."
	]
}
