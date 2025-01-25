//
//  BasicServerResponse.swift
//  DTOs
//
//  Created by Bonsung Koo on 25/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public protocol BasicServerResponse: Codable, Equatable, Sendable {
	associatedtype Response: Codable, Equatable, Sendable
	
	var data: Response { get }
}
