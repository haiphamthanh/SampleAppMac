//
//  Level.swift
//  SampleAppMac
//
//  Created by HaiPham on 06/08/2022.
//

import Foundation

struct Level: Identifiable, Hashable {
	var id = UUID().uuidString
	var name: String
	var level2s: [Level2]
}

struct Level2: Identifiable, Hashable {
	var id = UUID().uuidString
	var name: String
	var level3s: [Level3]
}

struct Level3: Identifiable, Hashable {
	var id = UUID().uuidString
	var name: String
	var versions: [Version]
}

//struct Level4: Identifiable, Hashable {
//	var id = UUID().uuidString
//	var versions: [Version]
//}

struct Version: Identifiable, Hashable {
	var id = UUID().uuidString
	var name: String
	var values: [String: String]
}

struct Other: Identifiable, Hashable {
	var id = UUID().uuidString
	var name: String
	var value: String
}
