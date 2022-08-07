//
//  Level2Model.swift
//  SampleAppMac
//
//  Created by HaiPham on 06/08/2022.
//

import Foundation

class Level2Model: ObservableObject {
	@Published var level2Wrappers: [Level2Wrapper]
	@Published var selectedLevel2: Other?
	init(level2Wrappers: [Level2Wrapper]) {
		self.level2Wrappers = level2Wrappers
	}
}
