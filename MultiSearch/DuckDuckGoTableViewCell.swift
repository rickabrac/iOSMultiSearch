//
//  DuckDuckGoTableViewCell.swift
//  MultiSearch
//  Created by Rick Tyler
//

import UIKit

class DuckDuckGoTableViewCell: UITableViewCell {
	@IBOutlet weak var link: UILabel!
	@IBOutlet weak var summary: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
