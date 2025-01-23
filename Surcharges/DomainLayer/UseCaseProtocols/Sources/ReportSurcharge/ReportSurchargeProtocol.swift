//
//  ReportSurchargeProtocol.swift
//  UseCaseProtocols
//
//  Created by Bonsung Koo on 22/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import Entities

public protocol ReportSurchargeProtocol: UseCaseWithErrorProtocol
where RequestValue == ReportSurchargeRequest,
			ResponseValue == ReportSurchargeResponse,
			ERROR == ReportSurchargeError {
	
}
