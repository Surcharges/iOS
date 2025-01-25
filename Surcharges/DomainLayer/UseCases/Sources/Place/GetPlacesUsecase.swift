//
//  GetPlacesUsecase.swift
//  UseCases
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import UseCaseProtocols
import RepositoryProtocols
import Entities
import DTOs

public struct GetPlacesUsecase<R: PlaceRepositoryProtocol>: GetPlacesUsecaseProtocol {
	public typealias RequestValue = Entities.GetPlacesRequest
	public typealias ResponseValue = Entities.GetPlacesResponse
	public typealias ERROR = Entities.GetPlacesError
	
	private let _placeRepository: R
	
	public init(placeRepository: R) {
		_placeRepository = placeRepository
	}
  
  public func invoke(requestValue: RequestValue) async throws(ERROR) -> ResponseValue {
		
		var usrLocation: DTOs.GetPlacesRequest.UserLocation? {
			if let userLocation = requestValue.userLocation {
				return .init(latitude: userLocation.latitude, longitude: userLocation.longitude)
			} else {
				return nil
			}
		}
		
		do {
			
			let result = try await _placeRepository.getPlaces(
				request: .init(
					searchText: requestValue.searchText,
					nextPageToken: requestValue.nextPageToken,
					userLocation: usrLocation
				)
			)
			
			let places = result.places.map { _place -> Entities.GetPlacesResponse.Item in
				let place = ConvertDTOtoEntity.place(dto: _place)
				
				var surchargeStatus: Entities.SurchargeStatus {
					switch _place.surchargeStatus {
					case .UNKNOWN: return .unknown
					case .REPORTED: return .reported
					case .CONFIRMED: return .confirmed
					case .none: return .unknown
					}
				}
				
				var updatedDate: Entities.TimeStamp? {
					if let updatedDate = _place.reportedDate {
						return .init(nanoseconds: updatedDate._nanoseconds, seconds: updatedDate._seconds)
					} else {
						return nil
					}
				}
				
				return .init(place: place, surcharge: .init(status: surchargeStatus, rate: _place.surchargeRate, updatedDate: updatedDate))
			}
			
			return .init(items: places, nextPageToken: result.nextPageToken)
			
		} catch(let error) {
			switch error {
			case .notFound:
				throw .noResults
			}
		}
  }
}
