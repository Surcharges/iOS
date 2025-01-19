//
//  Surcharge.swift
//  Models
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct Surcharge: Equatable, Sendable {
	public let status: SurchargeStatus
	public let rate: Double?
	public let updatedDate: Date?
	
	public init(status: SurchargeStatus, rate: Double?, updatedDate: Date?) {
		self.status = status
		self.rate = rate
		self.updatedDate = updatedDate
	}
}
