//
//  GoogleResult.swift
//  MultiSearch
//  Created by Rick Tyler
//

import Foundation

class GoogleResult: SearchResult {
	var link: String?       // backend response property
	var snippet: String?    // backend response property
	
	// MARK: SearchResult conformance
	
	var _text: String { guard let text = snippet else { return "" }; return text }
	var _url: String { guard let url = link else { return "" }; return url }
}
