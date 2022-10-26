//
//  DuckDuckGoSearch.swift
//  MultiSearch
//  Created by Rick Tyler
//

import Foundation

class DuckDuckGoSearch: SearchRequest {
	typealias SearchRequest = DuckDuckGoSearch
	typealias SearchResult = DuckDuckGoResult
	
	private var Topics: [DuckDuckGoResult]?           	// Codable backend response property
	private var RelatedTopics: [DuckDuckGoResult]?      // Codable backend response property
	
	func getResult() -> [DuckDuckGoResult] {
		var result: [DuckDuckGoResult] = []
		if let topics = Topics {
			for item in topics {
				if let _ = item.Text {
					result.append(item)
				} else {
					result += topics
				}
			}
		}
		guard let relatedTopics = RelatedTopics else { return result }
		for item in relatedTopics {
			if let _ = item.Text {
				result.append(item)
			} else if let topics = item.Topics {
				result += topics
			}
		}
		return result
	}
}

// MARK: Codable backend response properties

struct DuckDuckGoResult: Codable {
	var Text: String?
	var FirstURL: String?
	var Topics: [DuckDuckGoResult]?
}

// MARK: SearchResult conformance

extension DuckDuckGoResult: SearchResult {
	var _text: String { guard let text = Text else { return "" }; return text }
	var _url: String { guard let url = FirstURL else { return "" }; return url }
}

// MARK: DuckDuckGo API

class DuckDuckGoAPI: WebSearchAPI<DuckDuckGoSearch, DuckDuckGoResult> {
	override func getUrlString(_ input: String) -> String {
		return "https://api.duckduckgo.com/?q=" + input + "&format=json"
	}
	
	override func getHeaders() -> [(String, String)] { return [] }
}
