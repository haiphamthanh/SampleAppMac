//
//  SettingsListView.swift
//  SampleAppMac
//
//  Created by HaiPham on 06/08/2022.
//

import SwiftUI

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

struct SettingsListView_Previews: PreviewProvider {
    static var previews: some View {
		SettingsListView(settingsCategory: Category(name: "Sample"))
    }
}
