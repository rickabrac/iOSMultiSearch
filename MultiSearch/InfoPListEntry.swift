//
//  InfoPlistEntry.swift
//  MultiSearch
//  Created by Rick Tyler
//

import Foundation

struct InfoPListEntry {
	var value: String = ""
	
	init(_ keyName: String) {
		if keyName.count == 0 {
			return
		}
		if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
			let plist = NSDictionary(contentsOfFile: path)
			guard let value = plist?.object(forKey: keyName) as? String else { return }
			self.value = value
		}
	}
}
