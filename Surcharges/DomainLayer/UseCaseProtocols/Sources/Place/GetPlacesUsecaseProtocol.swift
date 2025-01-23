//
//  GetPlacesUsecaseProtocol.swift
//  UseCaseProtocols
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import Entities

public protocol GetPlacesUsecaseProtocol: UseCaseWithErrorProtocol
where RequestValue == GetPlacesRequest,
			ResponseValue == GetPlacesResponse,
			ERROR == GetPlacesError {
  
}
