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
		level2Model = Level2Model(level2Wrappers: level.level2Wrappers)
	}
	
	var body: some View {
		HStack {
			TabView {
				ForEach(level2Model.level2Wrappers) { level2Wrapper in
					contentView(level2Wrapper: level2Wrapper)
						.tabItem {
							Image(systemName: "gearshape")
							Text(level2Wrapper.name)
						}
						.frame(alignment: .leading)
				}
			}
			.frame(maxWidth: 200)
			
			if let selectedLevel2 = selectedLevel2 {
				DetailView(level2: selectedLevel2)
			} else {
				Spacer()
			}
		}
		.frame(alignment: .leading)
	}
	
	@ViewBuilder
	func contentView(level2Wrapper: Level2Wrapper) -> some View {
		List(level2Wrapper.level2s) { level2 in
			Text(level2.name)
				.onTapGesture {
					self.selectedLevel2 = level2
				}
				.font(.custom("AmericanTypewriter", fixedSize: 14).weight(.regular))
					  .padding(4)
					  .listRowBackground(Group {
						  if selectedLevel2 == level2 {
							  Color.gray.mask(RoundedRectangle(cornerRadius: 8))
						  } else { Color.clear }
					  })
		}
		.navigationTitle(level.name)
	}
}

//struct SettingsListView_Previews: PreviewProvider {
//    static var previews: some View {
//		SettingsListView(settingsCategory: Category(name: "Sample"))
//    }
//}
