//
//  GetPlaceUsecaseProtocol.swift
//  UseCaseProtocols
//
//  Created by Bonsung Koo on 17/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import Entities

public protocol GetPlaceUsecaseProtocol: UseCaseWithErrorProtocol
where RequestValue == GetPlaceRequest,
			ResponseValue == GetPlaceResponse,
			ERROR == GetPlaceError {
	
}
