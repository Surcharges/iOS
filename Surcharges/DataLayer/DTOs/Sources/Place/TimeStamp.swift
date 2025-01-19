//
//  TimeStamp.swift
//  DTOs
//
//  Created by Bonsung Koo on 17/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct TimeStamp: Codable, Equatable, Sendable {
	public let _nanoseconds: UInt
	public let _seconds: UInt
}
