//
//  NetworkError.swift
//  Networks
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
	case systemError
	case badRequest
	case unauthorised
	case forbidden
	case notFound
	case methodNotAllowed
	case deprecatedAPI
	case serverError
	case gatewayTimeout
  case failureResponseDecoding(reason: String)
  case unknown
}
