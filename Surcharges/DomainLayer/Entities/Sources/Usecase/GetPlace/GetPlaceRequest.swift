//
//  GetPlaceRequest.swift
//  Entities
//
//  Created by Bonsung Koo on 17/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct GetPlaceRequest: Equatable, Sendable {
	public let placeId: String
	
	public init(placeId: String) {
		self.placeId = placeId
	}
}
