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

public struct GetPlacesUsecase<R: PlaceRepositoryProtocol>: GetPlacesUsecaseProtocol {
	public typealias RequestValue = GetPlacesRequest
	public typealias ResponseValue = GetPlacesResponse
	public typealias ERROR = GetPlacesError
	
	private let _placeRepository: R
	
	public init(placeRepository: R) {
		_placeRepository = placeRepository
	}
  
  public func invoke(requestValue: RequestValue) async -> Result<ResponseValue, ERROR> {
		
		let result = await _placeRepository.getPlaces(
			request: .init(searchText: requestValue.searchText, nextPageToken: requestValue.nextPageToken)
		)
		
		switch result {
		case .success(let response):
			
			if response.places.isEmpty {
				return .failure(.noResults)
			}
			
			let places = response.places.map { place -> GetPlacesResponse.Item in
				
				var location: Location? {
					if let location = place.location {
						return .init(latitude: location.latitude, longitude: location.longitude)
					} else {
						return nil
					}
				}
				
				var surchargeStatus: SurchargeStatus {
					switch place.surchargeStatus {
					case .UNKNOWN: return .unknown
					case .REPORTED: return .reported
					case .CONFIRMED: return .confirmed
					default: return .unknown
					}
				}
				
				var updatedDate: TimeStamp? {
					if let updatedDate = place.reportedDate {
						return .init(nanoseconds: updatedDate._nanoseconds, seconds: updatedDate._seconds)
					} else {
						return nil
					}
				}
				
				return .init(
					place: .init(
						id: place.id,
						displayName: .init(text: place.displayName.text, languageCode: place.displayName.languageCode),
						addressComponents: place.addressComponents.map {
							.init(longText: $0.longText, shortText: $0.shortText, types: $0.types)
						},
						location: location
					),
					surcharge: .init(status: surchargeStatus, rate: place.rate, updatedDate: updatedDate)
				)
			}
			
			return .success(.init(items: places, nextPageToken: response.nextPageToken))
			
		case .failure:
			return .failure(.unknown)
		}
		
  }
}
