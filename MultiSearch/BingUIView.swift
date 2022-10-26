//
//  BingUIView.swift
//  MultiSearch
//  Created by Rick Tyler
//

import SwiftUI

struct BingUIView: View {
	@ObservedObject var viewModel: BingViewModel
	@FocusState private var isFocused: Bool
	@State private var input: String = ""
	@State private var selection: String?
	@State var presentedAsModal: Bool = false
	@Environment(\.colorScheme) var colorScheme: ColorScheme
	
	var body: some View {
		ZStack(alignment: .leading) {
			if viewModel.searchInProgress() {
				ProgressView().frame(maxWidth: .infinity, alignment: .center)
			} else if viewModel.items?.count == 0 {
				Text(NSLocalizedString("noResults", comment: ""))
					.font(.system(size: 17.0, weight: .semibold, design: .default))
					.frame(maxWidth: .infinity, alignment: .center)
					.padding(.bottom, 5)
			}
				
			VStack(alignment: .leading) {
				HStack {
					Text(" ")
					MyTextField("", text: $input).focused($isFocused).onAppear {
						DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
							// won't work if delay is too short
							self.isFocused = true
						}
					}
					.onSubmit {
						viewModel.search(input)
					}
					.autocapitalization(.none)
					.disableAutocorrection(true)
					.foregroundColor(.primary)
					.accentColor(colorScheme == .dark ? .white : .black)
					.frame(height: 18)
					.padding(5)
					.font(.system(size: 15, weight: .regular, design: .default))
					.textFieldStyle(.roundedBorder)
					Text(" ")
				}
				if let items = viewModel.items {
					List(items, id: \.self, selection: $selection) { item in
						if let snippet = item.snippet, let url = item.url {
							Button(snippet) { self.presentedAsModal = true }
							.font(.system(size: 14.0))
							.sheet(isPresented: self.$presentedAsModal) {
								SearchResultUIView(url: url, presentedAsModal: self.presentedAsModal)
							}
						}
					}
					.listStyle(.plain)
					.accentColor(colorScheme == .dark ? .white : .black)
					.accessibility(label: Text("BingTableView"))
				}
			}
			.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.topLeading)
		}
	}
}

struct BingView_Previews: PreviewProvider {
	static var previews: some View {
		let viewModel = BingViewModel(api: BingAPI())
		BingUIView(viewModel: viewModel)
	}
}

struct MyTextField: View {
	let title: String
	@Binding var text: String
	@State private var isEditing: Bool = false
	private var isClear: Bool {
		return self.isEditing && !self.text.isEmpty
	}
	 
	init(_ title: String, text: Binding<String>) {
		self.title = title
		self._text = text
	}
	 
	var body: some View {
		ZStack(alignment: .trailing) {
			TextField(self.title, text: self.$text) { isEditing in
				self.isEditing = isEditing
			} onCommit: {
				self.isEditing = false
			}
			.font(.system(size: 14.0))
			if self.text.count > 0 {
				Button {
					self.text = ""
				} label: {
					Image(systemName: "multiply.circle.fill").foregroundColor(.secondary)
				}
				.buttonStyle(PlainButtonStyle())
				.padding(5)
			}
		}
		.frame(alignment: .trailing)
	}
}
