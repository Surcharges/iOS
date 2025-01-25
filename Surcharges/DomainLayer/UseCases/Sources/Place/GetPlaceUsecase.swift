//
//  GetPlaceUsecase.swift
//  UseCases
//
//  Created by Bonsung Koo on 17/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import UseCaseProtocols
import RepositoryProtocols
import Entities

public struct GetPlaceUsecase<R: PlaceRepositoryProtocol>: GetPlaceUsecaseProtocol {
	public typealias RequestValue = GetPlaceRequest
	public typealias ResponseValue = GetPlaceResponse
	public typealias ERROR = GetPlaceError
	
	private let _placeRepository: R
	
	public init(placeRepository: R) {
		_placeRepository = placeRepository
	}
	
	public func invoke(requestValue: RequestValue) async throws(ERROR) -> ResponseValue {
		
		do {
			
			let result = try await _placeRepository.getPlace(request: .init(placeId: requestValue.placeId))
			
			let place = ConvertDTOtoEntity.place(dto: result.place)
//			let surcharge = ConvertDTOtoEntity.surcharge(dto: result.place)
			
			var surchargeStatus: Entities.SurchargeStatus {
				switch result.place.surchargeStatus {
				case .UNKNOWN: return .unknown
				case .REPORTED: return .reported
				case .CONFIRMED: return .confirmed
				case .none: return .unknown
				}
			}
			
			var updatedDate: Entities.TimeStamp? {
				if let updatedDate = result.place.reportedDate {
					return .init(nanoseconds: updatedDate._nanoseconds, seconds: updatedDate._seconds)
				} else {
					return nil
				}
			}
			
			return .init(place: place, surcharge: .init(status: surchargeStatus, rate: result.place.surchargeRate, updatedDate: updatedDate))
			
		} catch(let error) {
			switch error {
			case .notFound:
				throw .notFound
			}
		}
	}
}
