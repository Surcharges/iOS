//
//  AddressComponents.swift
//  Entities
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct AddressComponents: Codable, Equatable, Sendable {
	public let longText: String
	public let shortText: String
	public let types: [String]
//	public let languageCode: String
	
	public init(longText: String, shortText: String, types: [String]) {
		self.longText = longText
		self.shortText = shortText
		self.types = types
	}
}
