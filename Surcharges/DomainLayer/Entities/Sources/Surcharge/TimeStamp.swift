//
//  TimeStamp.swift
//  Entities
//
//  Created by Bonsung Koo on 20/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct TimeStamp: Codable, Equatable, Sendable {
	public let nanoseconds: UInt
	public let seconds: UInt
	
	public init(nanoseconds: UInt, seconds: UInt) {
		self.nanoseconds = nanoseconds
		self.seconds = seconds
	}
}
