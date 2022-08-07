//
//  Level2View.swift
//  SampleAppMac
//
//  Created by HaiPham on 06/08/2022.
//

import SwiftUI

struct Level2View: View {
	var level: Level
	@ObservedObject var level2Model: Level2Model
	@State private var selectedLevel2: Level2?
	
	init(level: Level) {
		self.level = level
		level2Model = Level2Model(level2s: level.level2s)
	}
 
	var body: some View {
//		TabView {
//			Text("Bananas 🍌🍌")
//				.tabItem {
//					
//					Image(systemName: "gearshape")
//					Text(setting.name)
//				}
//			Text("Apples 🍏🍏")
//				.tabItem {
//					
//					Image(systemName: "gearshape")
//					Text(setting.name)
//				}
//			Text("Peaches 🍑🍑")
//		}
//		.foregroundColor(Color.white)
//		.tabItem {
//			
//			Image(systemName: "gearshape")
//			Text(setting.name)
//		}
		
		List(level2Model.level2s) { level2 in
			NavigationLink(destination: DetailView(level2: level2),
						   tag: level2,
						   selection: $selectedLevel2) {
				HStack {
					Image(systemName: "gearshape")
					Text(level2.name)
						.font(.custom("AmericanTypewriter", fixedSize: 16).weight(.regular))
				}
			}
		}
		.navigationTitle(level.name)
	}
}

//struct SettingsListView_Previews: PreviewProvider {
//    static var previews: some View {
//		SettingsListView(settingsCategory: Category(name: "Sample"))
//    }
//}
