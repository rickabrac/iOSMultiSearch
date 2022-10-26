//
//  GoogleViewController.swift
//  MultiSearch
//  Created by Rick Tyler
//

import UIKit

class GoogleViewController: UIViewController {
	var viewModel: GoogleViewModel?
	
	let search = UITextField()
	let tableView = UITableView()
	let noResults = UILabel(frame: CGRect(x: 0, y:0, width: 200, height: 34))
	let spinner = UIActivityIndicatorView(style: .medium)
	
	@objc func clearTextField() {
		search.text = ""
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Google"
		view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
		
		// configure search field
		search.delegate = self
		search.translatesAutoresizingMaskIntoConstraints = false
		search.layer.cornerRadius = 5.0
		search.autocapitalizationType = .none
		search.font = UIFont.systemFont(ofSize: 14.0)
		search.tintColor = .black
		search.backgroundColor = .systemGray5
		search.clearButtonMode = .always
		let leftView = UIView(frame: CGRect(x: 0, y:0, width: 7, height: search.frame.size.height))
		leftView.backgroundColor = search.backgroundColor;
		search.leftView = leftView
		search.leftViewMode = .always
		view.addSubview(search)
		var constraints = [NSLayoutConstraint]()
		constraints.append(search.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18))
		constraints.append(search.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18))
		constraints.append(search.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -4))
		constraints.append(search.heightAnchor.constraint(equalToConstant: 35))
		NSLayoutConstraint.activate(constraints)
		
		// configure tableView
		tableView.delegate = self
		tableView.dataSource = self
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(GoogleTableViewCell.self as AnyClass, forCellReuseIdentifier: "GoogleSearchCell")
		tableView.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
		view.addSubview(tableView)
		tableView.accessibilityIdentifier = "GoogleSearchTableView"
		constraints = []
		constraints.append(tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
		constraints.append(tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
		constraints.append(tableView.topAnchor.constraint(equalTo: search.bottomAnchor))
		constraints.append(tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
		NSLayoutConstraint.activate(constraints)
		
		// configure noResults
		noResults.text = NSLocalizedString("noResults", comment: "")
		noResults.center = view.center
		noResults.textColor = traitCollection.userInterfaceStyle == .dark ? .white : .black
		noResults.font = UIFont.boldSystemFont(ofSize: 17.0)
		noResults.center = view.center
		noResults.textAlignment = .center
		view.addSubview(noResults)
		view.sendSubviewToBack(noResults)
		
		// confiture activity indicator
		spinner.center = view.center
		spinner.startAnimating()
		view.addSubview(spinner)
		view.sendSubviewToBack(self.spinner)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if viewModel == nil {
			viewModel = GoogleViewModel(api: GoogleAPI(), enableCaching: true)
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

extension GoogleViewController: ViewController {
	func viewModelDidUpdate() {
		DispatchQueue.main.async {
			defer { self.tableView.reloadData() }
			guard let viewModel = self.viewModel else { return }
			if viewModel.searchInProgress() {
				self.view.sendSubviewToBack(self.noResults)
				self.view.bringSubviewToFront(self.spinner)
			} else {
				self.view.sendSubviewToBack(self.spinner)
				if viewModel.items?.count == 0 {
					self.view.bringSubviewToFront(self.noResults)
				} else {
					self.view.sendSubviewToBack(self.noResults)
				}
			}
		}
	}
}
	
// MARK: UITextFieldDelegate conformance

extension GoogleViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard let input = textField.text, let viewModel = viewModel else { return false }
		search.resignFirstResponder()
		tableView.setContentOffset(.zero, animated: false)
		guard let text = search.text else { return false }
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

extension GoogleViewController: UITableViewDataSource {
	var numberOfSections: Int { return 1 }

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let viewModel = viewModel else { return 0 }
		return viewModel.numberOfRowsInSection(section: section)
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoogleSearchCell", for: indexPath) as? GoogleTableViewCell else { return UITableViewCell() }
		cell.link.text = viewModel?.urlForRowAt(indexPath: indexPath)
		guard let text = viewModel?.textForRowAt(indexPath: indexPath),
		let searchText = search.text else { return UITableViewCell() }
		let range = (text.lowercased() as NSString).range(of: searchText.lowercased())
		let attributedString = NSMutableAttributedString(string: text)
		attributedString.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14.0)], range: range)
		cell.link.text = viewModel?.urlForRowAt(indexPath: indexPath)
		cell.summary.attributedText = attributedString
		cell.summary.sizeToFit()
		cell.accessibilityIdentifier = "GoogleSearchCell" + String(indexPath.row)
		return cell
	}
}

// MARK: UITableViewDelegate conformance

extension GoogleViewController: UITableViewDelegate {
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
