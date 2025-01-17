//
//  GetPlacesResponse.swift
//  Entities
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct GetPlacesResponse: Equatable, Sendable {
	
	public struct Item: Equatable, Sendable {
		public let place: Place
		public let surcharge: Surcharge
		
		public init(place: Place, surcharge: Surcharge) {
			self.place = place
			self.surcharge = surcharge
		}
	}
	
	public let items: [Item]
	public let nextPageToken: String?
	
	public init(items: [Item], nextPageToken: String?) {
		self.items = items
		self.nextPageToken = nextPageToken
	}
	
}
