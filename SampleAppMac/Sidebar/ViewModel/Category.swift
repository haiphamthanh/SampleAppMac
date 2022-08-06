//
//  Category.swift
//  SampleAppMac
//
//  Created by HaiPham on 06/08/2022.
//

import Foundation

struct Category: Identifiable, Hashable {
	var id = UUID().uuidString
	var name: String
}
