//
//  PlaceRepository.swift
//  Repositories
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import DTOs
import Networks
import RepositoryProtocols
import AppStatusServiceProtocol

public struct PlaceRepository<AppStatusService: AppStatusServiceProtocol>: PlaceRepositoryProtocol {
	
	public typealias AppStatusService = AppStatusService
	
	private let _appStatusService: AppStatusService
	
	public init(appStatusService: AppStatusService) {
		_appStatusService = appStatusService
	}
	
	public func getPlaces(request: GetPlacesRequest) async -> GetPlacesResponse {
		
		let result = await API.request(
			dto: GetPlacesResponse.self,
			router: PlaceRouter.places(
				searchText: request.searchText,
				nextPageToken: request.nextPageToken,
				latitude: request.userLocation?.latitude,
				longitude: request.userLocation?.longitude
			)
		)
		
		switch result {
		case .success(let response):
			
			if let response = response {
				return response
			}
			
		case .failure(let error):
			
			await errorHandler(appStatusService: _appStatusService, error: error)
			
		}
		
		return .init(places: [], nextPageToken: nil)
	}
	
	public func getPlace(request: GetPlaceRequest) async -> Result<GetPlaceResponse, ResponseError> {
		let result = await API.request(
			dto: Place.self,
			router: PlaceRouter.place(id: request.placeId)
		)
		
		switch result {
		case .success(let response):
			
			if let response = response {
				return .success(.init(place: response))
			} else {
				return .failure(.unknown)
			}
			
		case .failure(let error):
			
			switch error {
			case .tokenInvalid, .forbidden:
				return .failure(.notAuthorized)
			default:
				return .failure(.unknown)
			}
			
		}
		
	}
}
