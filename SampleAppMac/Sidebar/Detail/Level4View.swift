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
	@State var isOn = false
	
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
			.frame(maxWidth: 200, maxHeight: .infinity)
			
			VStack {
				HStack {
					viewCookView()
						.background(Color.red)
					modView()
						.background(Color.yellow)
				}
			}
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
					HStack {
						Text(version.version)
							.onTapGesture {
								level4Model.selectedVersion = version
							}
						
						Spacer()
						
						Button {
							level4Model.removeVersion(version: version)
						} label: {
							Image(systemName: "trash.fill")
						}
					}
					.font(.custom("AmericanTypewriter", fixedSize: 14).weight(.regular))
						  .padding(4)
						  .listRowBackground(Group {
							  if level4Model.selectedVersion == version {
								  Color.gray.mask(RoundedRectangle(cornerRadius: 8))
							  } else { Color.clear }
						  })
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
							level4Model.selectedOther = other
						}
						.font(.custom("AmericanTypewriter", fixedSize: 14).weight(.regular))
						.padding(4)
						.listRowBackground(Group {
							if level4Model.selectedOther == other {
								Color.gray.mask(RoundedRectangle(cornerRadius: 8))
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
				.font(.custom("AmericanTypewriter", fixedSize: 16).weight(.regular))
				.foregroundColor(Color.black)
				.padding(4)
			
			TextView(text: level4Model.paramInView())
				.background(Color.tertiaryBackground)
		}
	}
	
	@ViewBuilder
	func modView() -> some View {
		VStack(alignment: .leading, spacing: 0) {
			Text("Modifier")
				.font(.custom("AmericanTypewriter", fixedSize: 16).weight(.regular))
				.foregroundColor(Color.black)
				.frame(maxWidth: .infinity, alignment: .center)
				.padding(4)
			
			// Menu
			HStack(spacing: 0) {
				Button {
					isOn = !level4Model.execute()
				} label: {
					Text("RUN")
				}
				.buttonStyle(NeumorphicButtonStyle(colorScheme: colorScheme))
				.frame(maxHeight: 50)
				.padding(4)
				
				Spacer()
				
				Button {
					level4Model.addMoreParam()
				} label: {
					Image(systemName: "plus.square.fill.on.square.fill")
				}
				.buttonStyle(NeumorphicButtonStyle(colorScheme: colorScheme))
				.frame(maxHeight: 50)
				.padding(4)
				
				Button {
					isOn = !level4Model.addNewVersion()
				} label: {
					Text("Save as new version")
				}
				.buttonStyle(NeumorphicButtonStyle(colorScheme: colorScheme))
				.frame(maxHeight: 50)
				.padding(4)
				
				Button {
					level4Model.resetAllParams()
				} label: {
					Text("Reset all params")
				}
				.buttonStyle(NeumorphicButtonStyle(colorScheme: colorScheme))
				.frame(maxHeight: 50)
				.padding(4)
			}
			.frame(maxWidth: .infinity)
			.background(Color.gray)
			
			List {
				ForEach(0..<level4Model.versionKeys.count, id: \.self) { index in
					HStack {
						TextField(level4Model.versionKeys[index], text: $level4Model.versionKeys[index])
							.modifier(ClearButton(text: $level4Model.versionKeys[index]))
						
						TextField(level4Model.versionValues[index], text: $level4Model.versionValues[index])
							.modifier(ClearButton(text: $level4Model.versionValues[index]))
						
						Button {
							level4Model.removeParam(index: index)
						} label: {
							Image(systemName: "trash.fill")
						}
					}
				}
			}
		}
		.alert("。Please choose cook\n。Make sure params is not empty\n。Make sure params is valid", isPresented: $isOn) {
			Button("OK", role: .cancel) { }
		}
	}
	
	func beautiful(dic: [String: String]?) -> String {
		guard let dic = dic else {
			return ""
		}
		
		do {
			let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
			// here "jsonData" is the dictionary encoded in JSON data
			
			let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
			// here "decoded" is of type `Any`, decoded from JSON data
			
			if let theJSONData = try?  JSONSerialization.data(withJSONObject: decoded, options: .prettyPrinted),
			   let theJSONText = String(data: theJSONData, encoding: String.Encoding.ascii) {
				
				print("JSON string = \n\(theJSONText)")
				return theJSONText
			}
		} catch {
			print(error.localizedDescription)
		}
		
		return ""
	}
}

struct ClearButton: ViewModifier
{
	@Binding var text: String
	
	public func body(content: Content) -> some View
	{
		ZStack(alignment: .trailing)
		{
			content
			
			if !text.isEmpty
			{
				Button(action:
						{
					self.text = ""
				})
				{
					Image(systemName: "delete.left")
						.foregroundColor(Color.gray)
				}
				.padding(.trailing, 8)
			}
		}
	}
}

/// A wrapper around NSTextView so we can get multiline text editing in SwiftUI.
struct TextView: NSViewRepresentable {
	@Binding private var text: String
	private let isEditable: Bool
	
	init(text: Binding<String>, isEditable: Bool = true) {
		_text = text
		self.isEditable = isEditable
	}
	
	init(text: String) {
		self.init(text: Binding<String>.constant(text), isEditable: false)
	}
	
	func makeNSView(context: Context) -> NSScrollView {
		let text = NSTextView()
		text.backgroundColor = isEditable ? .textBackgroundColor : .clear
		text.delegate = context.coordinator
		text.isRichText = false
		text.font = NSFont.monospacedSystemFont(ofSize: NSFont.systemFontSize, weight: .regular)
		text.autoresizingMask = [.width]
		text.translatesAutoresizingMaskIntoConstraints = true
		text.isVerticallyResizable = true
		text.isHorizontallyResizable = false
		text.isEditable = isEditable
		
		let scroll = NSScrollView()
		scroll.hasVerticalScroller = true
		scroll.documentView = text
		scroll.drawsBackground = false
		
		return scroll
	}
	
	func updateNSView(_ view: NSScrollView, context: Context) {
		let text = view.documentView as? NSTextView
		text?.string = self.text
		
		guard context.coordinator.selectedRanges.count > 0 else {
			return
		}
		
		text?.selectedRanges = context.coordinator.selectedRanges
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	class Coordinator: NSObject, NSTextViewDelegate {
		var parent: TextView
		var selectedRanges = [NSValue]()
		
		init(_ parent: TextView) {
			self.parent = parent
		}
		
		func textDidChange(_ notification: Notification) {
			guard let textView = notification.object as? NSTextView else { return }
			parent.text = textView.string
			selectedRanges = textView.selectedRanges
		}
	}
}



import SwiftUI

public extension Color {
	
#if os(macOS)
	static let background = Color(NSColor.windowBackgroundColor)
	static let secondaryBackground = Color(NSColor.underPageBackgroundColor)
	static let tertiaryBackground = Color(NSColor.controlBackgroundColor)
#else
	static let background = Color(UIColor.systemBackground)
	static let secondaryBackground = Color(UIColor.secondarySystemBackground)
	static let tertiaryBackground = Color(UIColor.tertiarySystemBackground)
#endif
}
