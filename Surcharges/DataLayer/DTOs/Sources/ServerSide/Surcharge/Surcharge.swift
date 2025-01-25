//
//  Surcharge.swift
//  DTOs
//
//  Created by Bonsung Koo on 25/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct Surcharge: Codable, Equatable, Sendable {
	public let rate: Double?
	public let reportedDate: TimeStamp?
	public let status: SurchargeStatus
}
