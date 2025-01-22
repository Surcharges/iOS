//
//  SurchargeRepositoryProtocol.swift
//  RepositoryProtocols
//
//  Created by Bonsung Koo on 22/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import DTOs

public protocol SurchargeRepositoryProtocol: Sendable {
	func reportSurcharge(request: ReportSurchargeRequest) async throws(ResponseError)
}
