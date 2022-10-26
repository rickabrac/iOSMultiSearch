//
//  SearchResultUIWebView.swift
//  MultiSearch
//  Created by Rick Tyler
//

import SwiftUI

struct SearchResultUIWebView: UIViewControllerRepresentable {
	typealias UIViewControllerType = SearchResultViewController
	var url: String
	@Binding var presentedAsModal: Bool
	
	func makeUIViewController(context: Context) -> SearchResultViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: .main)
		let vc = storyboard.instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController
		vc.urlString = url
		return vc
	}
	
	func updateUIViewController(_ uiViewController: SearchResultViewController, context: Context) { }
}

