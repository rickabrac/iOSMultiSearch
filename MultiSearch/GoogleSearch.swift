//
//  GoogleSearch.swift
//  MultiSearch
//  Created by Rick Tyler
//

import Foundation

class GoogleSearch: SearchRequest {
	typealias SearchRequest = GoogleSearch
	typealias SearchResult = GoogleResult
	
	private var items: [GoogleResult]	// Codable backend response property
	
	// MARK: SearchRequest conformance

	func getResult() -> [GoogleResult] {
		return items
	}
}
