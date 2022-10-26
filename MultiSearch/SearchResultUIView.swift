//
//  SearchResultUIView.swift
//  MultiSearch
//  Created by Rick Tyler
//

import SwiftUI

struct SearchResultUIView: View {
	var url: String
	@State var presentedAsModal = false
	
    var body: some View {
		SearchResultUIWebView(url: url, presentedAsModal: self.$presentedAsModal)
    }
}
