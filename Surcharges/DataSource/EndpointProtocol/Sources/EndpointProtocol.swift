//
//  EndpointProtocol.swift
//  EndpointProtocol
//
//  Created by Bonsung Koo on 25/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public protocol EndpointProtocol: Sendable {
	init()
	var baseURL: String { get }
	var authorisationScheme: String { get }
	var authorisationToken: String { get }
}
