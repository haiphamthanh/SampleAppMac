//
//  SettingDetailsView.swift
//  SampleAppMac
//
//  Created by HaiPham on 06/08/2022.
//

import SwiftUI

struct SettingDetailsView: View {
	var setting: Setting
 
	var body: some View {
		Text(setting.value)
			.font(.title2)
			.padding(.horizontal)
			.navigationTitle(setting.name)
	}
}

struct SettingDetailsView_Previews: PreviewProvider {
    static var previews: some View {
		SettingDetailsView(setting: Setting(name: "Sample"))
    }
}
