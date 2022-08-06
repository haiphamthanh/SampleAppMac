//
//  ContentView.swift
//  Sample
//
//  Created by HaiPham on 17/07/2022.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		NavigationView {
			// The first column is the sidebar.
			Sidebar()
			
			// Initial content of the second column.
			EmptyView()
			
			// Initial content for the third column.
			Text("Select a category of settings in the sidebar.")
		}.toolbar {
			ToolbarItem(placement: ToolbarItemPlacement.navigation) {
				Button {
					NSApp.keyWindow?.firstResponder?.tryToPerform(
						#selector(NSSplitViewController.toggleSidebar(_:)), with: nil
					)
				} label: {
					Label("Toggle sidebar", systemImage: "sidebar.left")
				}
			}
		}
		
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}


struct Category: Identifiable, Hashable {
	var id = UUID().uuidString
	var name: String
}


struct Setting: Identifiable, Hashable {
	var id = UUID().uuidString
	var name: String
	var value: String {
		[
			"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
			"Pretium viverra suspendisse potenti nullam ac tortor vitae purus.",
			"Laoreet suspendisse interdum consectetur libero id faucibus nisl.",
			"Faucibus et molestie ac feugiat sed lectus vestibulum.",
			"Faucibus et molestie ac feugiat sed lectus vestibulum."
		][Int.random(in: 0..<5)]
	}
}

class CategoriesModel: ObservableObject {
	@Published var categories: [Category] = [Category(name: "Profile"),
											 Category(name: "Language"),
											 Category(name: "Connected Accounts"),
											 Category(name: "Color Theme")
	]
}

class SettingsModel: ObservableObject {
	@Published var settings = [Setting]()
	
	init(with category: String) {
		switch category {
		case "Profile":
			settings = [Setting(name: "Name"), Setting(name: "Picture"),
						Setting(name: "Gender")]
			
		case "Language":
			settings = [Setting(name: "English"), Setting(name: "German"),
						Setting(name: "French"), Setting(name: "Italian"),
						Setting(name: "Spanish"), Setting(name: "Greek"),
						Setting(name: "Russian"), Setting(name: "Hindi"),
						Setting(name: "Chinese")]
			
		case "Connected Accounts":
			settings = [Setting(name: "Facebook"), Setting(name: "Twitter"),
						Setting(name: "Instagram"), Setting(name: "Linkedin"),
						Setting(name: "Google")]
			
		case "Color Theme":
			settings = [Setting(name: "Red"), Setting(name: "Yellow"),
						Setting(name: "Purple"), Setting(name: "Green"),
						Setting(name: "Monochrome")]
			
		default: break
		}
	}
}
