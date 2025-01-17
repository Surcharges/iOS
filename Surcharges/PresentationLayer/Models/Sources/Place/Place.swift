//
//  Place.swift
//  Models
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct Place: Identifiable, Equatable, Sendable {
	public let id: String
	public let name: String
	public let address: String
	public let location: Location?
	public let surcharge: Surcharge
	
	public init(id: String, name: String, address: String, location: Location?, surcharge: Surcharge) {
		self.id = id
		self.name = name
		self.address = address
		self.location = location
		self.surcharge = surcharge
	}
}
