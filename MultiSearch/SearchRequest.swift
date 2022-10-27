//
//  SearchRequest.swift
//  MultiSearch
//  Created by Rick Tyler
//

protocol SearchRequest: Codable {
	associatedtype Result
	func getResult() -> [Result]
}
