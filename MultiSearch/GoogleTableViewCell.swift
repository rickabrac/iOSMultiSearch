//
//  GoogleTableViewCell.swift
//  MultiSearch
//  Created by Rick Tyler
//

import UIKit

class GoogleTableViewCell: UITableViewCell {
	var link: UILabel
	var summary: UILabel
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
		link = UILabel()
		summary = UILabel()
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
	}
	
	func configure() {
		link.translatesAutoresizingMaskIntoConstraints = false
		link.font = UIFont.boldSystemFont(ofSize: 14.0)
		addSubview(link)
		summary.numberOfLines = 0
		summary.font = UIFont.systemFont(ofSize: 14.0)
		addSubview(summary)
		var constraints = [NSLayoutConstraint]()
		constraints.append(link.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20.0))
		constraints.append(link.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20.0))
		constraints.append(link.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 13.0))
		constraints.append(link.heightAnchor.constraint(equalToConstant: 20))
		NSLayoutConstraint.activate(constraints)
		summary.translatesAutoresizingMaskIntoConstraints = false
		constraints = []
		constraints.append(summary.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20.0))
		constraints.append(summary.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20.0))
		constraints.append(summary.topAnchor.constraint(equalTo: link.safeAreaLayoutGuide.bottomAnchor, constant: 1.0))
		constraints.append(summary.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor))
		NSLayoutConstraint.activate(constraints)
	}
	
	required init?(coder: NSCoder) {
		fatalError("GoogleSearchCell: init(coder:) has not been implemented")
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
}
