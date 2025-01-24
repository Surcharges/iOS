//
//  FactoryProtocol.swift
//  Factories
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

@MainActor
public protocol FactoryProtocol {
  
	associatedtype AppStatusService
  associatedtype ViewModel
	associatedtype Endpoint
  
	func resolve(appStatusService: AppStatusService) -> ViewModel
}
