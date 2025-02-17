//
//  GetPlaceResponse.swift
//  DTOs
//
//  Created by Bonsung Koo on 17/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct GetPlaceServerResponse: BasicServerResponse {
	public var data: Place
}

public struct GetPlaceResponse: Codable, Equatable, Sendable {
	public let place: Place
	
	public init(place: Place) {
		self.place = place
	}
}
