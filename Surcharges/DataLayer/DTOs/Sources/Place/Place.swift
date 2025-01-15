//
//  Place.swift
//  DTOs
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct Place: Codable, Equatable, Sendable {
	public let id: String
	public let displayName: LocalizedText
	public let addressComponents: [AddressComponents]
	public let location: LatLng?
}
