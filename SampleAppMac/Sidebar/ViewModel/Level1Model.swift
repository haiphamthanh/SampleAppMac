//
//  Level1Model.swift
//  SampleAppMac
//
//  Created by HaiPham on 06/08/2022.
//

import Foundation

class Level1Model: ObservableObject {
	@Published var levels: [Level]
	init() {
		let values1 = ["a": "value", "a1": "value1", "a2": "value2", "a3": "value3"]
		let values2 = ["a2": "value2", "a21": "value21", "a22": "value22", "a23": "value23"]
		let values3 = ["a3": "value3", "a31": "value31", "a32": "value32", "a33": "value33"]
		
		
		let vers = [Version(name: "version 1", version: "20220801", values: values1),
					Version(name: "version 2", version: "20220801", values: values2),
					Version(name: "version 3", version: "20220801", values: values3)]
		
		let level31 = Level3(name: "Level31", versions: vers)
		let level32 = Level3(name: "Level32", versions: vers)
		let level33 = Level3(name: "Level33", versions: [])
		
		let level2 = Level2(name: "Level2", level3s: [level31, level32, level33])
		let level = Level(name: "level1", level2s: [level2])
		self.levels = [level]
	}
}
