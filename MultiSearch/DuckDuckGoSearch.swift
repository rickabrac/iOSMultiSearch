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
	
	// MARK: SearchRequest conformance
	
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
