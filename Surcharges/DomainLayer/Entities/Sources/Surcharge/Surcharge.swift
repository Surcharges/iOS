//
//  Surcharge.swift
//  Entities
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct Surcharge: Equatable, Sendable {
	public let rate: Double?
	public let status: SurchargeStatus?
	
	public init(rate: Double?, status: SurchargeStatus?) {
		self.rate = rate
		self.status = status
	}
}
