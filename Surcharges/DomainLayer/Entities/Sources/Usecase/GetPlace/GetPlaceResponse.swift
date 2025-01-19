//
//  GetPlaceResponse.swift
//  Entities
//
//  Created by Bonsung Koo on 17/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct GetPlaceResponse: Equatable, Sendable {
	
	public let place: Place
	public let surcharge: Surcharge
	
	public init(place: Place, surcharge: Surcharge) {
		self.place = place
		self.surcharge = surcharge
	}
}
