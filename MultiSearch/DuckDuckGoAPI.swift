//
//  DuckDuckGoAPI.swift
//  MultiSearch
//  Created by Rick Tyler
//

import Foundation

class DuckDuckGoAPI: WebSearchAPI<DuckDuckGoSearch, DuckDuckGoResult> {
	override func getUrlString(_ input: String) -> String {
		return "https://api.duckduckgo.com/?q=" + input + "&format=json"
	}
	
	override func getHeaders() -> [(String, String)] { return [] }
}
