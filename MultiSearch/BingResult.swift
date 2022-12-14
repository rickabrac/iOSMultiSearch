//
//  BingResult.swift
//  MultiSearch
//  Created by Rick Tyler
//

import Foundation

struct BingResult: SearchResult, Hashable {
	var url: String?        // backend response property
	var snippet: String?    // backend response property

	// MARK: SearchResult conformance

	var _text: String { guard let _text = snippet else { return "" }; return _text }
	var _url: String { guard let _url = url else { return "" }; return _url }
}

struct BingResultValue: Codable {
	var value: [BingResult]?
}
