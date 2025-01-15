//
//  FactoryProtocol.swift
//  Factories
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public protocol FactoryProtocol {
  
  associatedtype ViewModel
  
  static func resolve() -> ViewModel
}
