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
