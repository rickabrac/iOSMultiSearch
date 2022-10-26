//
//  DuckDuckGoViewController.swift
//  MultiSearch
//  Created by Rick Tyler
//

import UIKit

class DuckDuckGoViewController: UIViewController {
	var viewModel: DuckDuckGoViewModel?
	
	@IBOutlet weak var search: UITextField!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var noResults: UILabel!
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "DuckDuckGo"
		spinner.center = view.center
		spinner.startAnimating()
		noResults.center = view.center
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.accessibilityIdentifier = "DuckDuckGoSearchTableView"
		view.sendSubviewToBack(noResults)
		view.sendSubviewToBack(spinner)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if viewModel == nil {
			viewModel = DuckDuckGoViewModel(api: DuckDuckGoAPI())
			viewModel?.delegate = self
		}
		search.tintColor = traitCollection.userInterfaceStyle == .dark ? .white : .black
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
			self.search.becomeFirstResponder()
		}
	}
}

// MARK: ViewController conformance

extension DuckDuckGoViewController: ViewController {
	func viewModelDidUpdate() {
		DispatchQueue.main.async {
			defer { self.tableView.reloadData() }
			guard let viewModel = self.viewModel else { return }
			if viewModel.searchInProgress() {
				self.view.sendSubviewToBack(self.noResults)
				self.view.bringSubviewToFront(self.spinner)
			} else {
				self.view.sendSubviewToBack(self.spinner)
				if self.viewModel?.items?.count == 0 {
					self.view.bringSubviewToFront(self.noResults)
				} else {
					self.view.sendSubviewToBack(self.noResults)
				}
			}
		}
	}
}

// MARK: UITextFieldDelegate conformance

extension DuckDuckGoViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard let input = textField.text, let viewModel = viewModel else { return false }
		search.resignFirstResponder()
		tableView.setContentOffset(.zero, animated: false)
		guard let text = search?.text else { return false }
		viewModel.search(input)
		if text.count > 0 {
			view.bringSubviewToFront(spinner)
		}
		return false
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		self.view.sendSubviewToBack(self.noResults)
		return true
	}
}

// MARK: UITableViewDataSource conformance

extension DuckDuckGoViewController: UITableViewDataSource {
	var numberOfSections: Int { return 1 }

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let viewModel = viewModel else { return 0 }
		return viewModel.numberOfRowsInSection(section: section)
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as? DuckDuckGoTableViewCell else { return UITableViewCell() }
		cell.link.text = viewModel?.urlForRowAt(indexPath: indexPath)
		cell.summary.text = viewModel?.textForRowAt(indexPath: indexPath)
		cell.summary.sizeToFit()
		cell.accessibilityIdentifier = "DuckDuckGoSearchCell" + String(indexPath.row)
		return cell
	}
}

// MARK: UITableViewDelegate conformance
	
extension DuckDuckGoViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let viewModel = viewModel else { return }
		let urlString = viewModel.urlForRowAt(indexPath: indexPath)
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController
		vc.urlString = urlString
		present(vc, animated: true, completion: nil)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
