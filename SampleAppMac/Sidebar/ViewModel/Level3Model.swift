//
//  Level3Model.swift
//  SampleAppMac
//
//  Created by HaiPham on 07/08/2022.
//

import Foundation

class Level3Model: ObservableObject {
	@Published var level3s: [Level3]
	init(level3s: [Level3]) {
		self.level3s = level3s
	}
}
