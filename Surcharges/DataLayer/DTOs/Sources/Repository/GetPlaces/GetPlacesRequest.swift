//
//  GetPlacesRequest.swift
//  DTOs
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct GetPlacesRequest: Codable, Equatable, Sendable {
	
	public struct UserLocation: Codable, Equatable, Sendable {
		public let latitude: Double
		public let longitude: Double
		
		public init(latitude: Double, longitude: Double) {
			self.latitude = latitude
			self.longitude = longitude
		}
	}
	
	public let searchText: String
	public let nextPageToken: String?
	public let userLocation: UserLocation?
	
	public init(searchText: String, nextPageToken: String?, userLocation: UserLocation?) {
		self.searchText = searchText
		self.nextPageToken = nextPageToken
		self.userLocation = userLocation
	}
}
	

