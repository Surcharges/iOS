//
//  ResponseError.swift
//  DTOs
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public enum ResponseError: Error {
  case notAuthorized
  case noResult
  case unknown
}
