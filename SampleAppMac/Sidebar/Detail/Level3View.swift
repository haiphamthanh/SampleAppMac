//
//  Level3View.swift
//  SampleAppMac
//
//  Created by HaiPham on 07/08/2022.
//

import SwiftUI

struct Level3View: View {
	var level2: Level2
	@ObservedObject var level3Model: Level3Model
	@State private var selectedLevel3: Level3?
	var ontap: (Level3) -> Void
	
	init(level2: Level2, ontap: @escaping (Level3) -> Void) {
		self.level2 = level2
		self.ontap = ontap
		level3Model = Level3Model(level3s: level2.level3s)
	}
	
	var body: some View {
		VStack {
			Text("Level 3")
				.font(.custom("AmericanTypewriter", fixedSize: 16).weight(.regular))
				.foregroundColor(Color.black)
				.padding(4)
			
			List{
				ForEach(level3Model.level3s) { level3 in
					Text(level3.name)
						.onTapGesture {
							self.selectedLevel3 = level3
							ontap(level3)
						}
					//					.font(.system(size: 20, weight: .bold, design: .default))
						.font(.custom("AmericanTypewriter", fixedSize: 18).weight(.regular))
						.foregroundColor(selectedLevel3 == level3 ? Color.black : Color.white)
						.padding()
					//					.listRowBackground(self.selectedLevel3 == level3 ? Color.red : Color.clear)
						.listRowBackground(Group {
							if selectedLevel3 == level3 {
								Color.yellow.mask(RoundedRectangle(cornerRadius: 24))
							} else { Color.clear }
						})
				}
			}
		}
		.background(Color.red)
		.frame(maxWidth: 150, maxHeight: .infinity)
	}
}
