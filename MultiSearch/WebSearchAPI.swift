//
//  WebSearchAPI.swift
//  MultiSearch
//  Created by Rick Tyler
//
//  MARK: Generic web search API class
//

import Foundation

class WebSearchAPI<Search: SearchRequest, Result: SearchResult>: Codable {
	typealias Search = SearchRequest
	typealias Result = SearchResult
	var cannedResponseFileName: String
	var apiKey: String = ""
	
	init(cannedResponseFileName: String = "") {
		self.cannedResponseFileName = cannedResponseFileName
	}
	
	func fetch(_ input: String, completionHandler: @escaping ([SearchResult], String) -> Void) {
		if input.count == 0 {
			completionHandler([], "")
			return
		}
		let url: URL?
		if cannedResponseFileName.count > 0 {
			url = Bundle.main.url(forResource: cannedResponseFileName, withExtension: "json")
		} else {
			guard let input = input.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
			url = URL(string: getUrlString(input))
		}
		guard let url = url else { return }
		var request = URLRequest(url: url)
		for (key, value) in getHeaders() {
			request.setValue(value, forHTTPHeaderField: key)
		}
		request.httpMethod = "GET"
		let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
			var result = [SearchResult]()
			var errorString: String = ""
			defer {
				completionHandler(result, errorString)
			}
			if let error = error {
				errorString = "\(Search.self).fetch(): generic error (\(error))"
				return
			}
			if let response = response as? HTTPURLResponse, (201...299).contains(response.statusCode) {
				errorString = "\(Search.self).fetch(): HTTP error (\(response.statusCode))"
				return
			}
			if let data = data, let search = try? JSONDecoder().decode(Search.self, from: data) {
				result = search.getResult() as! [SearchResult]
			}
		})
		task.resume()
	}
	
	func getUrlString(_ input: String) -> String {
		fatalError("\(Search.self).getUrlString(): unimplemented")
	}
	
	func getHeaders() -> [(String, String)] {
		fatalError("\(Search.self): getHeaders() unimplemented")
	}
}
