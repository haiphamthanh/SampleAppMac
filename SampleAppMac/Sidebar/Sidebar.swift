//
//  Sidebar.swift
//  Sample
//
//  Created by HaiPham on 06/08/2022.
//

import SwiftUI

struct Sidebar: View {
	@ObservedObject var level1Model = Level1Model()
	@State private var selectedLevel: Level?
	
	var body: some View {
		List(level1Model.levels) { level in
			NavigationLink(
				destination: viewOnType(level),
				tag: level,
				selection: $selectedLevel,
				label: {
					HStack {
						Image(systemName: "folder")
						Text(level.name)
							.font(.custom("AmericanTypewriter", fixedSize: 14).weight(.regular))
					}
				})
		}
		.listStyle(SidebarListStyle())
		.frame(minWidth: 200)
	}
	
	@ViewBuilder
	func viewOnType(_ level: Level) -> some View {
		switch level.type {
		case .type1:
			Level2View(level: level)
		case .type2:
			Text("Select a category of settings in the sidebar.")
		}
	}
}

//struct Sidebar_Previews: PreviewProvider {
//	static var previews: some View {
//		Sidebar()
//	}
//}
