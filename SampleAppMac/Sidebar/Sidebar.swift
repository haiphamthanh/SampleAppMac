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
				destination: Level2View(level: level),
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
}

struct Sidebar_Previews: PreviewProvider {
	static var previews: some View {
		Sidebar()
	}
}
