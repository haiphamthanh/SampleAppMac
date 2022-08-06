//
//  SidebarMainView.swift
//  SampleAppMac
//
//  Created by HaiPham on 06/08/2022.
//

import SwiftUI

struct SidebarMainView: View {
	var body: some View {
		NavigationView {
			// The first column is the sidebar.
			Sidebar()
			
			// Initial content of the second column.
			EmptyView()
			
			// Initial content for the third column.
			Text("Select a category of settings in the sidebar.")
		}
	}
}

struct SidebarMainView_Previews: PreviewProvider {
	static var previews: some View {
		SidebarMainView()
	}
}
