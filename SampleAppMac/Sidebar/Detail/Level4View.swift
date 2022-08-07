//
//  Level4View.swift
//  SampleAppMac
//
//  Created by HaiPham on 07/08/2022.
//

import SwiftUI

struct Level4View: View {
	@Environment(\.colorScheme) private var colorScheme
	
	var level3: Level3
	@ObservedObject var level4Model: Level4Model
	@State private var selectedVersion: Version?
	
	// Others
	@State private var selectedOther: Other?
	
	init(level3: Level3) {
		self.level3 = level3
		level4Model = Level4Model(versions: level3.versions)
	}
	
	var body: some View {
		HStack {
			VStack(spacing: 0) {
				versionView()
					.background(Color.yellow)
				cookView()
					.background(Color.red)
			}
			.background(Color.gray)
			.frame(maxWidth: 150, maxHeight: .infinity)
			
			VStack {
				HStack {
					viewCookView()
						.background(Color.brown)
					modView()
						.background(Color.blue)
				}
				
				Button {
					print("Action")
				} label: {
					Text("RUN")
				}
				.buttonStyle(NeumorphicButtonStyle(colorScheme: colorScheme))
				.frame(maxWidth: 220, maxHeight: 50)
			}
			
			Spacer()
		}
	}
	
	@ViewBuilder
	func versionView() -> some View {
		VStack {
			Text("Version")
				.font(.custom("AmericanTypewriter", fixedSize: 16).weight(.regular))
				.foregroundColor(Color.black)
				.padding(4)
			List {
				ForEach(level4Model.versions) { version in
					Text(version.name)
						.onTapGesture {
							self.selectedVersion = version
						}
						.font(.custom("AmericanTypewriter", fixedSize: 14).weight(.regular))
						.padding()
				}
			}
		}
	}
	
	@ViewBuilder
	func cookView() -> some View {
		VStack {
			Text("Cook")
				.font(.custom("AmericanTypewriter", fixedSize: 16).weight(.regular))
				.foregroundColor(Color.black)
				.padding(4)
			List {
				ForEach(level4Model.others) { other in
					Text(other.name)
						.onTapGesture {
							self.selectedOther = other
						}
						.font(.custom("AmericanTypewriter", fixedSize: 14).weight(.light))
						.foregroundColor(selectedOther == other ? Color.black : Color.white)
						.padding(4)
						.listRowBackground(Group {
							if selectedOther == other {
								Color.yellow.mask(RoundedRectangle(cornerRadius: 24))
							} else { Color.clear }
						})
				}
			}
		}
	}
	
	@ViewBuilder
	func viewCookView() -> some View {
		VStack {
			Text("View")
			//			ForEach(selectedCo ?? []) { level4 in
			//				Text(level4.name)
			//					.onTapGesture {
			//						//						self.selectedLevel3 = level3
			//						//						ontap(level3)
			//					}
			//					.font(.custom("AmericanTypewriter", fixedSize: 14).weight(.regular))
			//					.padding()
			//			}
		}
	}
	
	@ViewBuilder
	func modView() -> some View {
		VStack {
			Text("Modifier")
			ForEach((selectedVersion?.values ?? [:]).sorted(by: >), id: \.key) { param in
				Text(param.key)
					.onTapGesture {
						//						self.selectedLevel3 = level3
						//						ontap(level3)
					}
					.font(.custom("AmericanTypewriter", fixedSize: 14).weight(.regular))
					.padding()
			}
		}
	}
}
