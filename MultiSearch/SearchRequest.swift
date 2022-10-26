//
//  SearchRequest.swift
//  MultiSearch
//  Created by Rick Tyler
//

protocol SearchRequest: Codable {
	associatedtype Search
	func getResult() -> [Search]
}
