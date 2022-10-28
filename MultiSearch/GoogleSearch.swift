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

	func getResult() -> [GoogleResult] {
		return items
	}
}

// MARK: SearchResult conformance

extension GoogleResult: SearchResult {
	var _text: String { guard let text = snippet else { return "" }; return text }
	var _url: String { guard let url = link else { return "" }; return url }
}

// MARK: Codable backend response properties

struct GoogleResult: Codable {
	var link: String?
	var snippet: String?
}

// MARK: Google API

class GoogleAPI: WebSearchAPI<GoogleSearch, GoogleResult> {
	let key = InfoPListEntry("Google Search API Key").value
	
	override func getUrlString(_ input: String) -> String {
		"https://www.googleapis.com/customsearch/v1?key=" + key + "&cx=07b20eac5d77b4925&q=" + input
	}
	
	override func getHeaders() -> [(String, String)] { [] }
}
