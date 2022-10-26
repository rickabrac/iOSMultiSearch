//
//  SearchResultViewController.swift
//  MultiSearch
//  Created by Rick Tyler
//

import UIKit
import WebKit

class SearchResultViewController: UIViewController {
	var urlString: String = ""
	@IBOutlet weak var webView: WKWebView!
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		webView.frame = view.frame
		webView.isOpaque = false
		webView.backgroundColor = UIColor.clear
		self.view.addSubview(webView)
		self.view.accessibilityIdentifier = "SearchResultView"
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		guard let url = URL(string: urlString) else { return }
		webView.load(URLRequest(url: url))
		if self.traitCollection.userInterfaceStyle == .dark {
			self.view.backgroundColor = .black
		} else {
			self.view.backgroundColor = .white
		}
	}
}
