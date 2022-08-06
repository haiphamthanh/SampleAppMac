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

struct SettingsListView: View {
	var settingsCategory: Category
	@ObservedObject var settingsModel: SettingsModel
	@State private var selectedSetting: Setting?
	
	init(settingsCategory: Category) {
		self.settingsCategory = settingsCategory
		settingsModel = SettingsModel(with: settingsCategory.name)
	}
 
	var body: some View {
		List(settingsModel.settings) { setting in
			NavigationLink(destination: SettingDetailsView(setting: setting),
						   tag: setting,
						   selection: $selectedSetting) {
				HStack {
					Image(systemName: "gearshape")
					Text(setting.name)
				}
			}
		}
		.navigationTitle(settingsCategory.name)
	}
}

struct SettingDetailsView: View {
	var setting: Setting
 
	var body: some View {
		Text(setting.value)
			.font(.title2)
			.padding(.horizontal)
			.navigationTitle(setting.name)
	}
}
