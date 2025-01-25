//
//  LocalizedText.swift
//  DTOs
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct LocalizedText: Codable, Equatable, Sendable {
	public let text: String
	public let languageCode: String
}
	
