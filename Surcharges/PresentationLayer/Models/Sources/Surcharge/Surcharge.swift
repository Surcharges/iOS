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
	
	public init(status: SurchargeStatus, rate: Double?) {
		self.status = status
		self.rate = rate
	}
}
