//
//  UseCaseProtocol.swift
//  UseCaseProtocols
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import Entities

public protocol UseCaseBaseProtocol: Sendable {
	associatedtype RequestValue
}
	
public protocol UseCaseNonResponseValueProtocol: UseCaseBaseProtocol where ERROR: UseCaseError {
	associatedtype RequestValue
	associatedtype ERROR
	
	func invoke(requestValue: RequestValue) async throws(ERROR)
}

public protocol UseCaseNonErrorProtocol: UseCaseBaseProtocol {
	associatedtype RequestValue
	associatedtype ResponseValue
	
	func invoke(requestValue: RequestValue) async -> ResponseValue
}

public protocol UseCaseWithErrorProtocol: UseCaseBaseProtocol where ERROR: UseCaseError {
	associatedtype ResponseValue
	associatedtype ERROR
	
	func invoke(requestValue: RequestValue) async throws(ERROR) -> ResponseValue
}
