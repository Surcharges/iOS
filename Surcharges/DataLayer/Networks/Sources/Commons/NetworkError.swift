//
//  NetworkError.swift
//  Networks
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
	case notFound
  case tokenInvalid
  case systemConnection
  case methodNotAllowed
	case deprecatedAPI
  case serverError
  case gatewayTimeout
  case responseIsEmpty
  case badRequest
  case forbidden
  case failureResponseDecoding(reason: String)
  case unknown
}
