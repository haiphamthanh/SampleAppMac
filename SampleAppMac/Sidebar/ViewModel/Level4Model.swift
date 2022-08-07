//
//  Level4Model.swift
//  SampleAppMac
//
//  Created by HaiPham on 07/08/2022.
//

import Foundation

class Level4Model: ObservableObject {
	@Published var versions: [Version]
	@Published var others: [Other]
	init(versions: [Version]) {
		self.versions = versions
		self.others = [Other(name: "name1", value: "Value1"),
					   Other(name: "name2", value: "Value2"),
					   Other(name: "name3", value: "Value3")]
	}
}
