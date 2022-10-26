//
//  BingUIController.swift
//  MultiSearch
//  Created by Rick Tyler
//

import UIKit
import SwiftUI

class BingUIController: UIViewController {	// referenced by Main.storyboard
	var viewModel: BingViewModel?
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Bing"
		if viewModel == nil {
			viewModel = BingViewModel(api: BingAPI())
		}
		guard let viewModel = viewModel else { return }
		let BingUIView = BingUIView(viewModel: viewModel)
		lazy var hostingController = UIHostingController(rootView: BingUIView)
		self.addChild(hostingController)
		self.view.addSubview(hostingController.view)
		hostingController.view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			hostingController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
			hostingController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			hostingController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			hostingController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
		])
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
}
