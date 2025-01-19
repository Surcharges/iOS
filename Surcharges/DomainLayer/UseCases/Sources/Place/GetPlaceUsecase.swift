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
	
	public func invoke(requestValue: RequestValue) async -> Result<ResponseValue, ERROR> {
		let result = await _placeRepository.getPlace(request: .init(placeId: requestValue.placeId))
		
		switch result {
		case .success(let response):
			
			var location: Location? {
				if let location = response.place.location {
					return .init(latitude: location.latitude, longitude: location.longitude)
				} else {
					return nil
				}
			}
			
			var surchargeStatus: SurchargeStatus {
				switch response.place.surchargeStatus {
				case .UNKNOWN: return .unknown
				case .REPORTED: return .reported
				case .CONFIRMED: return .confirmed
				default: return .unknown
				}
			}
			
			var updatedDate: TimeStamp? {
				if let updatedDate = response.place.reportedDate {
					return .init(nanoseconds: updatedDate._nanoseconds, seconds: updatedDate._seconds)
				} else {
					return nil
				}
			}
			
			return .success(
				.init(
					place: .init(
						id: response.place.id,
						displayName: .init(text: response.place.displayName.text, languageCode: response.place.displayName.languageCode),
						addressComponents: response.place.addressComponents.map {
							.init(longText: $0.longText, shortText: $0.shortText, types: $0.types)
						},
						location: location
					),
					surcharge: .init(status: surchargeStatus, rate: response.place.rate, updatedDate: updatedDate)
				)
			)
			
		case .failure:
			return .failure(.unknown)
		}
	}
	
}
