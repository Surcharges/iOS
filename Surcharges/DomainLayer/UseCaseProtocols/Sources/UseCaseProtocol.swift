//
//  UseCaseProtocol.swift
//  UseCaseProtocols
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public protocol UseCaseProtocol: Sendable where ERROR: Error {
  associatedtype RequestValue
  associatedtype ResponseValue
  associatedtype ERROR
  
  func invoke(requestValue: RequestValue) async -> Result<ResponseValue, ERROR>
}
