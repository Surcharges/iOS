//
//  RepositoryProtocol.swift
//  RepositoryProtocols
//
//  Created by Bonsung Koo on 22/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import AppStatusServiceProtocol

public protocol RepositoryProtocol: Sendable where AppStatusService: AppStatusServiceProtocol, ERROR: Error {
	associatedtype AppStatusService
	associatedtype ERROR
	
	func errorHandlerExceptNotFound(appStatusService: AppStatusService, error: ERROR) async
}
