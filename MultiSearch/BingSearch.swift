//
//  BingSearch.swift
//  MultiSearch
//  Created by Rick Tyler
//

import Foundation

class BingSearch: SearchRequest {
	typealias SearchRequest = BingSearch
	typealias SearchResult = BingResult
	
	private var webPages: BingResultValue?    // backend response property
	
	// MARK: SearchResult conformance
	
	func getResult() -> [BingResult] {
		guard let result = webPages?.value else { return [] }
		return result
	}
}
