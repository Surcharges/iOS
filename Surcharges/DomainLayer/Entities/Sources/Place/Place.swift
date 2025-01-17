//
//  PlaceModel.swift
//  Entities
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct Place: Equatable, Sendable {
	public let id: String
	public let displayName: LocalizedText
	public let addressComponents: [AddressComponents]
	public let location: Location?

	public init(id: String, displayName: LocalizedText, addressComponents: [AddressComponents], location: Location?) {
		self.id = id
		self.displayName = displayName
		self.addressComponents = addressComponents
		self.location = location
	}
}
