//
//  UseCaseError.swift
//  Entities
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public protocol UseCaseError: Error, Sendable {
	static var unknown: Self { get }
}
