//
//  ReportSurchargeError.swift
//  Entities
//
//  Created by Bonsung Koo on 22/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public enum ReportSurchargeError: UseCaseError {
	case notAuthorized
	case unknown
}
