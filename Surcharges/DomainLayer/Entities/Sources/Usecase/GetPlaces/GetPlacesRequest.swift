//
//  GetPlacesRequest.swift
//  Entities
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct GetPlacesRequest: Equatable, Sendable {
	public let searchText: String
	public let nextPageToken: String?
	
	public init(searchText: String, nextPageToken: String?) {
		self.searchText = searchText
		self.nextPageToken = nextPageToken
	}
}
