//
//  ReportSurchargeRequest.swift
//  DTOs
//
//  Created by Bonsung Koo on 22/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct ReportSurchargeRequest: Codable, Equatable, Sendable {
	public let plcaeId: String
	public let totalAmount: Double
	public let surchargeAmount: Double
	public let receiptImageData: Data
	
	public init(plcaeId: String, totalAmount: Double, surchargeAmount: Double, receiptImageData: Data) {
		self.plcaeId = plcaeId
		self.totalAmount = totalAmount
		self.surchargeAmount = surchargeAmount
		self.receiptImageData = receiptImageData
	}
}
