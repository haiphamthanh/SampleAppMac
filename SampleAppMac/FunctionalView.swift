//
//  FunctionalView.swift
//  SampleAppMac
//
//  Created by HaiPham on 12/08/2022.
//

import SwiftUI


enum MenuType {
	case type1
	case type2
	case type3
	case type4
	case type5
}

struct Menu: Identifiable, Hashable {
	var id = UUID().uuidString
	var name: String
	let type: MenuType
}

struct FunctionalView: View {
	private let listMenu: [Menu]
	@State private var selectedMenu: Menu?
	
	init() {
		self.listMenu = [Menu(name: "Action 1", type: .type1),
						 Menu(name: "Action 2", type: .type2),
						 Menu(name: "Action 3", type: .type3),
						 Menu(name: "Action 4", type: .type4),
						 Menu(name: "Action 5", type: .type5)]
	}
	
	var body: some View {
		List(listMenu) { menu in
			Text(menu.name)
				.onTapGesture {
					let cmd = commandFactory(menu)
					cmd.run()
				}
				.font(.custom("AmericanTypewriter", fixedSize: 14).weight(.regular))
				.padding(4)
				.listRowBackground(Group {
					if selectedMenu == menu {
						Color.gray.mask(RoundedRectangle(cornerRadius: 8))
					} else { Color.clear }
				})
		}
	}
	
	func commandFactory(_ menu: Menu) -> Command{
		switch menu.type {
		case .type1:
			return SomethingPCommand()
		case .type2:
			return SomethingThCommand()
		case .type3:
			return SomethingBackCommand()
		case .type4:
			return SomethingMoniPCommand()
		case .type5:
			return SomethingMoniThCommand()
		}
	}
}


// 1. Make multiple versions for somethingP
// 2. Make multiple versions for somethingTah
// 3. Store all in pool
// 4. Copy collected files to dest folder
protocol Command {
	func run()
}

class SomethingPCommand: Command {
	// Init
	
	func run() {
		// Load param modifier in somethingP pool
		// Save param modifier (replace old)
		// Edit cutomization file as somethingP
		// Go to folder
		// Run sh file
	}
}

class SomethingThCommand: Command {
	// Init
	
	func run() {
		// Load param modifier in somethingTah pool
		// Save param modifier (replace old)
		// Edit cutomization file as somethingTah
		// Go to folder
		// Run sh file
	}
}

class SomethingBackCommand: Command {
	// Init
	
	func run() {
		// Load param modifier in somethingBack pool
		// Save param modifier (replace old)
		// Edit cutomization file as somethingP
		// Go to folder
		// Run sh file
	}
}

class SomethingMoniPCommand: Command {
	// Init
	
	func run() {
		// Load mod in json file
		// Decrypt p file confirm to mod
		// Copy p to destination folder
		// Edit cutomization file as moni
		// Go to folder
		// Run sh file
	}
}

class SomethingMoniThCommand: Command {
	// Init
	
	func run() {
		// Load mod in json file
		// Decrypt p file confirm to mod
		// Copy p to destination folder
		// Edit cutomization file as moni
		// Go to folder
		// Run sh file
	}
}

struct Functional_Previews: PreviewProvider {
	static var previews: some View {
		FunctionalView()
	}
}
