//
//  GetPlacesUsecase.swift
//  UseCases
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import UseCaseProtocols

public struct GetPlacesUsecase: GetPlacesUsecaseProtocol {
  public typealias RequestValue = String
  
  public typealias ResponseValue = String
  
  public typealias ERROR = Error
  
  public func invoke(requestValue: RequestValue) async -> Result<ResponseValue, ERROR> {
    return .success("")
  }
}
