//
//  Level2Model.swift
//  SampleAppMac
//
//  Created by HaiPham on 06/08/2022.
//

import Foundation

class Level2Model: ObservableObject {
	@Published var level2s: [Level2]
	init(level2s: [Level2]) {
		self.level2s = level2s
	}
}
