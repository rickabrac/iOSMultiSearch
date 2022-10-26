//
//  SearchResult.swift
//  MultiSearch
//  Created by Rick Tyler
//

protocol SearchResult: Codable {
	var _text: String { get }
	var _url: String { get }
}
