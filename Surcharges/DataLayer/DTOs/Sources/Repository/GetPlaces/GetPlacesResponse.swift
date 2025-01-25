//
//  GetPlacesResponse.swift
//  DTOs
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct GetPlacesServerResponse: BasicServerResponse {
	public var data: GetPlacesResponse
}

public struct GetPlacesResponse: Codable, Equatable, Sendable {
	public let places: [Place]
	public let nextPageToken: String?
	
	public init(places: [Place], nextPageToken: String?) {
		self.places = places
		self.nextPageToken = nextPageToken
	}
}
