//
//  BingAPI.swift
//  MultiSearch
//  Created by Rick Tyler
//

import Foundation

class BingAPI: WebSearchAPI<BingSearch, BingResult> {
	var key = InfoPListEntry("Bing Search API Key")
	
	override func getUrlString(_ input: String) -> String {
		return "https://api.bing.microsoft.com/v7.0/search?q=" + input
	}
	
	override func getHeaders() -> [(String, String)] {
		[("Ocp-Apim-Subscription-Key", key.value)]
	}
}
