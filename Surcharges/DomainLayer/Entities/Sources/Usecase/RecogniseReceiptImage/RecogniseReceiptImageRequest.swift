//
//  RecogniseReceiptImageRequest.swift
//  Entities
//
//  Created by Bonsung Koo on 21/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct RecogniseReceiptImageRequest: Equatable, Sendable {
	public let placeName: String
	public let image: Data
	
	public init(placeName: String, image: Data) {
		self.placeName = placeName
		self.image = image
	}
}
