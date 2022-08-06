//
//  Sidebar.swift
//  Sample
//
//  Created by HaiPham on 06/08/2022.
//

import SwiftUI

struct Sidebar: View {
	@ObservedObject var settingsCategories = CategoriesModel()
	@State private var selectedCategory: Category?
	
	var body: some View {
		List(settingsCategories.categories) { category in
			NavigationLink(
				destination: SettingsListView(settingsCategory: category),
				tag: category,
				selection: $selectedCategory,
				label: {
					HStack {
						Image(systemName: "folder")
						Text(category.name)
					}
				})
		}
		.listStyle(SidebarListStyle())
		.frame(minWidth: 200)
	}
}

struct Sidebar_Previews: PreviewProvider {
	static var previews: some View {
		Sidebar()
	}
}
