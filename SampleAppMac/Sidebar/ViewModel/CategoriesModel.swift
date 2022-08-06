//
//  CategoriesModel.swift
//  SampleAppMac
//
//  Created by HaiPham on 06/08/2022.
//

import Foundation

class CategoriesModel: ObservableObject {
	@Published var categories: [Category] = [Category(name: "Profile"),
											 Category(name: "Language"),
											 Category(name: "Connected Accounts"),
											 Category(name: "Color Theme")
	]
}
