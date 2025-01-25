//
//  ReportSurchargeResponse.swift
//  DTOs
//
//  Created by Bonsung Koo on 23/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct ReportSurchargeServerResponse: BasicServerResponse {
	public var data: ReportSurchargeResponse
}

public struct ReportSurchargeResponse: Codable, Equatable, Sendable {
	public let place: Place
	public let surcharge: Surcharge
	
	public init(place: Place, surcharge: Surcharge) {
		self.place = place
		self.surcharge = surcharge
	}
}
