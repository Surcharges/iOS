//
//  EndPointMock.swift
//  UseCasesTests
//
//  Created by Bonsung Koo on 29/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import EndpointProtocol

public struct EndPointMock: EndpointProtocol {
	public init() {}
	public var baseURL: String { "" }
	public var authorisationScheme: String { "" }
	public var authorisationToken: String { "" }
}
