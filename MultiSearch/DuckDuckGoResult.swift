//
//  DuckDuckGoResult.swift
//  MultiSearch
//  Created by Rick Tyler
//

import Foundation

struct DuckDuckGoResult: SearchResult {
	var Text: String?                      // backend response property
	var FirstURL: String?                  // backend response property
	var Topics: [DuckDuckGoResult]?        // backend response property
	
	// MARK: SearchResult conformance

	var _text: String { guard let text = Text else { return "" }; return text }
	var _url: String { guard let url = FirstURL else { return "" }; return url }
}

