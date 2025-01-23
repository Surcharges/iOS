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
  
  public func invoke(requestValue: RequestValue) async -> Result<ResponseValue, ERROR> {
		
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
				let surcharge = ConvertDTOtoEntity.surcharge(dto: _place)
				
				return .init(place: place, surcharge: surcharge)
				
			}
			
			return .success(.init(items: places, nextPageToken: result.nextPageToken))
			
		} catch(let error) {
			switch error {
			case .notFound:
				return .failure(.noResults)
			}
		}
  }
}
