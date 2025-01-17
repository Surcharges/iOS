//
//  MainModel.swift
//  Models
//
//  Created by Bonsung Koo on 16/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct MainModel: Equatable, Sendable {
	public let places: [Place]
	public let isExistNextPage: Bool
	
	public init(places: [Place], isExistNextPage: Bool) {
		self.places = places
		self.isExistNextPage = isExistNextPage
	}
}
