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

public struct PlaceRepository: PlaceRepositoryProtocol {
	
	public init() { }
	
	public func getPlaces(request: GetPlacesRequest) async -> Result<GetPlacesResponse, ResponseError> {
		
		let result = await API.request(
			dto: GetPlacesResponse.self,
			router: PlaceRouter.places(searchText: request.searchText, nextPageToken: request.nextPageToken)
		)
		
		switch result {
		case .success(let response):
			
			if let response = response {
				return .success(response)
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
