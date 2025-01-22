//
//  ReportSurchargeRequest.swift
//  Entities
//
//  Created by Bonsung Koo on 22/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct ReportSurchargeRequest: Equatable, Sendable {
	public let placeId: String
	public let totalAmount: Double
	public let surchargeAmount: Double
	public let receiptImageData: Data
	
	public init(placeId: String, totalAmount: Double, surchargeAmount: Double, receiptImageData: Data) {
		self.placeId = placeId
		self.totalAmount = totalAmount
		self.surchargeAmount = surchargeAmount
		self.receiptImageData = receiptImageData
	}
}
