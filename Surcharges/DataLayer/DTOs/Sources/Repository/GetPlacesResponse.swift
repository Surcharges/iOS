//
//  GetPlacesResponse.swift
//  DTOs
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct GetPlacesResponse: Codable, Equatable, Sendable {
	public let places: [Place]
	public let nextPageToken: String?
}
