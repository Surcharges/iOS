//
//  HTTPURLResponse+extension.swift
//  Networks
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
  
  enum Status: Int, Codable {
    case ok = 200
		case created = 201
    case noContent = 204
    case badRequest = 400
    case notAuthorized = 401
    case forbidden = 403
		case notFound = 404
    case methodNotAllowed = 405
		case gone = 410
    case serverError = 500
    case gatewayTimeout = 504
    case undefinedError = -1
  }
  
  var status: Status {
    return Status(rawValue: statusCode) ?? .undefinedError
  }
}
