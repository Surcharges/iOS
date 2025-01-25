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
import EndpointProtocol

public struct PlaceRepository<
	AppStatusService: AppStatusServiceProtocol,
	Endpoint: EndpointProtocol
>: PlaceRepositoryProtocol {
	
	public typealias AppStatusService = AppStatusService
	
	private let _appStatusService: AppStatusService
	
	public init(appStatusService: AppStatusService) {
		_appStatusService = appStatusService
	}
	
	public func getPlaces(request: GetPlacesRequest) async throws(GetPlacesError) -> GetPlacesResponse {
		do {
			
			let result = try await API.request(
				dto: GetPlacesServerResponse.self,
				router: PlaceRouter<Endpoint>.places(
					searchText: request.searchText,
					nextPageToken: request.nextPageToken,
					latitude: request.userLocation?.latitude,
					longitude: request.userLocation?.longitude
				)
			)
			
			return .init(places: result.data.places, nextPageToken: result.data.nextPageToken)
			
		} catch {
			await errorHandlerExceptNotFound(appStatusService: _appStatusService, error: error)
		}
		
		throw .notFound
	}
	
	public func getPlace(request: GetPlaceRequest) async throws(GetPlaceError) -> GetPlaceResponse {
		
		do {
			
			let result = try await API.request(
				dto: GetPlaceServerResponse.self,
				router: PlaceRouter<Endpoint>.place(id: request.placeId)
			)
			
			return .init(place: result.data)
			
		} catch {
			
			await errorHandlerExceptNotFound(appStatusService: _appStatusService, error: error)
			
		}
		
		throw .notFound
	}
}
