//
//  WebSearchViewModel.swift
//  MultiSearch
//  Created by Rick Tyler
//
// MARK: Generic web search view model class
//

import Foundation

class WebSearchViewModel<Search: SearchRequest, Result: SearchResult>: ViewModel {
	var delegate: ViewController?
	var cachingEnabled: Bool
	var api: WebSearchAPI<Search, Result>
	var searching: Bool = false
	@Published var items: [Result]?
	
	init(api: WebSearchAPI<Search, Result>, enableCaching: Bool = false) {
		self.api = api
		self.cachingEnabled = enableCaching
	}
	
	func search(_ input: String) {
		items = nil
		searching = true
		delegate?.viewModelDidUpdate()
		if cachingEnabled {
			do {
				// google does not return same result twice so optional caching
				if let encoded = UserDefaults.standard.data(forKey: input.lowercased()) {
					guard let cached = try JSONDecoder().decode(CachedResult<Result>?.self, from: encoded) else { return }
					if Date().timeIntervalSince1970 - cached.created.timeIntervalSince1970 < 86400 {
						items = cached.items
						delegate?.viewModelDidUpdate()
						searching = false
						return
					} else {
						UserDefaults.standard.removeObject(forKey: input.lowercased())    // expire cached result after 24 hours
					}
				}
			} catch {
				print("WebSearchViewModel: JSONEncoder.decode failed on cached result")
			}
		}
		api.fetch(input) { (result, error) in
			if !error.isEmpty {
				self.searching = false
				return
			}
			self.items = result as? [Result]
			self.searching = false
			self.delegate?.viewModelDidUpdate()
			if self.cachingEnabled {
				let encoder = JSONEncoder()
				guard let items = self.items else { return }
				let cachedResult = CachedResult<Result>(search: input, items: items)
				do {
					let data = try encoder.encode(cachedResult)
					UserDefaults.standard.set(data, forKey:input.lowercased())
				} catch {
					fatalError("WebSearchViewModel: JSONEncoder.encode() failed cached result")
				}
			}
		}
	}
	
	func searchInProgress() -> Bool {
		return searching
	}
	
	func numberOfRowsInSection(section: Int) -> Int {
		guard let items = items  else { return 0 }
		return items.count
	}
	
	func textForRowAt(indexPath: IndexPath) -> String {
		if indexPath.section != 0 { return "" }
		guard let items = items else { return "" }
		return items[indexPath.row]._text
	}
	
	func urlForRowAt(indexPath: IndexPath) -> String {
		if indexPath.section != 0 { return "" }
		guard let items = items else { return "" }
		return items[indexPath.row]._url
	}
}

// Codable cached web search result

class CachedResult<Result: SearchResult>: Codable, Comparable {
	var search: String
	var items: [Result]
	var created = Date()
	
	static func == (lhs: CachedResult<Result>, rhs: CachedResult<Result>) -> Bool {
		return lhs.search == rhs.search
	}
	
	static func < (lhs: CachedResult<Result>, rhs: CachedResult<Result>) -> Bool {
		return lhs.search < rhs.search
	}
	
	init(search: String, items: [Result]) {
		self.search = search
		self.items = items
	}
}
