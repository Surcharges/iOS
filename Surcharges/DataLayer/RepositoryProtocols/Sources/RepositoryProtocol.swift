//
//  RepositoryProtocol.swift
//  RepositoryProtocols
//
//  Created by Bonsung Koo on 22/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import AppStatusServiceProtocol
import EndpointProtocol

public protocol RepositoryProtocol: Sendable
where AppStatusService: AppStatusServiceProtocol,
			Endpoint: EndpointProtocol,
			ERROR: Error {
	
	associatedtype AppStatusService
	associatedtype Endpoint
	associatedtype ERROR
	
	func errorHandlerExceptNotFound(appStatusService: AppStatusService, error: ERROR) async
}
