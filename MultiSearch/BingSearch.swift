//
//  BingSearch.swift
//  MultiSearch
//  Created by Rick Tyler
//

import Foundation

class BingSearch: SearchRequest {
	typealias SearchRequest = BingSearch
	typealias SearchResult = BingResult
	
	private var webPages: BingResultValue?    // Codable backend response property
	
	func getResult() -> [BingResult] {
		guard let result = webPages?.value else { return [] }
		return result
	}
}

// MARK: SearchResult conformance
	
extension BingResult: SearchResult {
	var _text: String { guard let _text = snippet else { return "" }; return _text }
	var _url: String { guard let _url = url else { return "" }; return _url }
}

// MARK: Codable backend response properties

struct BingResult: Codable, Hashable {
	var url: String?
	var snippet: String?
}

struct BingResultValue: Codable {
	var value: [BingResult]?
}

// MARK: Bing API

class BingAPI: WebSearchAPI<BingSearch, BingResult> {
	var key = InfoPListEntry("Bing Search API Key")
	
	override func getUrlString(_ input: String) -> String {
		return "https://api.bing.microsoft.com/v7.0/search?q=" + input
	}
	
	override func getHeaders() -> [(String, String)] {
		[("Ocp-Apim-Subscription-Key", key.value)]
	}
}
