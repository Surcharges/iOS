//
//  RecogniseReceiptImageResponse.swift
//  Entities
//
//  Created by Bonsung Koo on 21/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct RecogniseReceiptImageResponse: Equatable, Sendable {
	
	public let totalAmount: Double
	public let surchargeAmount: Double
	
	public init (totalAmount: Double, surchargeAmount: Double) {
		self.totalAmount = totalAmount
		self.surchargeAmount = surchargeAmount
	}
}
