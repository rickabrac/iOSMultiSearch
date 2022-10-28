//
//  GoogleAPI.swift
//  MultiSearch
//  Created by Rick Tyler
//

import Foundation

class GoogleAPI: WebSearchAPI<GoogleSearch, GoogleResult> {
	let key = InfoPListEntry("Google Search API Key").value
	
	override func getUrlString(_ input: String) -> String {
		"https://www.googleapis.com/customsearch/v1?key=" + key + "&cx=07b20eac5d77b4925&q=" + input
	}
	
	override func getHeaders() -> [(String, String)] { [] }
}
