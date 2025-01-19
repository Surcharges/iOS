//
//  SurchargeStatus.swift
//  DTOs
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public enum SurchargeStatus: String, Codable, Equatable, Sendable {
	case UNKNOWN, REPORTED, CONFIRMED
}
