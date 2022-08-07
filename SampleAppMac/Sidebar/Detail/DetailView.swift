//
//  DetailView.swift
//  SampleAppMac
//
//  Created by HaiPham on 07/08/2022.
//

import SwiftUI

struct DetailView: View {
	var level2: Level2
	@ObservedObject var level3Model: Level3Model
	@State private var selectedLevel3: Level3?
	
	init(level2: Level2) {
		self.level2 = level2
		level3Model = Level3Model(level3s: level2.level3s)
	}
	
	var body: some View {
		HStack {
			Level3View(level2: level2) { level3 in
				selectedLevel3 = level3
			}
			
			contentView(level3: selectedLevel3)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.background(Color.blue)
		}
	}
	
	@ViewBuilder
	func contentView(level3: Level3?) -> some View {
		if let level3 = level3 {
			Level4View(level3: level3)
		} else {
			Text("Select level 3 to show detail")
		}
	}
}
