//
//  Level4Model.swift
//  SampleAppMac
//
//  Created by HaiPham on 07/08/2022.
//

import Foundation

class Level4Model: ObservableObject {
	@Published var versions: [Version]
	@Published var others: [Other]
	@Published var selectedOther: Other?
	@Published var selectedVersion: Version? {
		didSet {
			resetAllParams()
		}
	}
	
	private let newUnknowKey = "unknow_name"
	private let newUnknowValue = "unknow_value"
	
	
	@Published var versionKeys = [String]()
	@Published var versionValues = [String]()
	
	init(versions: [Version]) {
		self.versions = versions
		self.others = [Other(name: "name1", value: "Value1"),
					   Other(name: "name2", value: "Value2"),
					   Other(name: "name3", value: "Value3")]
		
		self.selectedVersion = versions.first
	}
	
	func resetAllParams() {
		versionKeys  = selectedVersion?.values.map({ $0.key }) ?? []
		versionValues  = selectedVersion?.values.map({ $0.value }) ?? []
	}
	
	func addMoreParam() {
		versionKeys.append(newUnknowKey)
		versionValues.append(newUnknowValue)
	}
	
	func addNewVersion() -> Bool {
		let allValidKeys = versionKeys.filter({ !($0.isEmpty || $0 == newUnknowKey) })
		let allValidValues = versionValues.filter({ !($0.isEmpty || $0 == newUnknowValue) })
		
		var validParams = [String: String]()
		for i in 0..<allValidKeys.count {
			if i >= allValidValues.count {
				continue
			}
			
			let key = allValidKeys[i]
			let value = allValidValues[i]
			
			validParams[key] = value
		}
		
		if validParams.isEmpty {
			return false
		}
		
		let name = selectedVersion?.name ?? "new_prefix" //TODO: correct `new_prefix`
		
		let date = Date()
		let calendar = Calendar.current
		let year = calendar.component(.year, from: date)
		let month = calendar.component(.month, from: date)
		let day = calendar.component(.day, from: date)
		let hour = calendar.component(.hour, from: date)
		let minute = calendar.component(.minute, from: date)
		let version = "\(year)\(month)\(day).\(hour).\(minute)"
		print(beautiful(dic: validParams))
		
		// TODO: Remove later
		// TODO: Add these into local file
		versions.append(Version(name: name, version: version, values: validParams))
		return true
	}
	
	func removeVersion(version: Version) {
		let removeIndex = versions.firstIndex(of: version)
		var currentIndex = 0
		if let selectedVersion = selectedVersion {
			currentIndex = versions.firstIndex(of: selectedVersion) ?? 0
		}
		
		if currentIndex == removeIndex {
			let upIndex = currentIndex + 1
			let downIndex = currentIndex - 1
			currentIndex = upIndex < versions.count ? upIndex : downIndex >= 0 ? downIndex : -1
			selectedVersion = currentIndex >= 0 ? versions[currentIndex] : nil
		}
		
		// TODO: Remove version in root
		versions.remove(version)
	}
	
	func removeParam(index: Int) {
		versionKeys.remove(at: index)
		versionValues.remove(at: index)
	}
	
	func execute() -> Bool {
		guard let selectedOther = selectedOther, !versionKeys.isEmpty else {
			return false
		}
		
		let allValidKeys = versionKeys.filter({ !($0.isEmpty || $0 == newUnknowKey) })
		let allValidValues = versionValues.filter({ !($0.isEmpty || $0 == newUnknowValue) })
		
		var params = [String: String]()
		for i in 0..<allValidKeys.count {
			if i >= allValidValues.count {
				continue
			}
			
			let key = allValidKeys[i]
			let value = allValidValues[i]
			
			params[key] = value
		}
		
		print("=============> Execution <=============")
		print("Params-----")
		print(beautiful(dic: params))
		print("Others-----")
		print("Name: \(selectedOther.name)")
		print("Value: \(selectedOther.value)")
		
		return true
	}
	
	func paramInView() -> String {
		beautiful(dic: selectedVersion?.values)
	}
}

extension Level4Model {
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
				return theJSONText
			}
		} catch {
			print(error.localizedDescription)
		}
		
		return ""
	}
}

extension RangeReplaceableCollection where Element : Equatable {
	@discardableResult
	mutating func remove(_ element : Element) -> Element?
	{
		if let index = firstIndex(of: element) {
			return remove(at: index)
		}
		return nil
	}
}
