//
//  PlaceRepositoryMock.swift
//  UseCasesTests
//
//  Created by Bonsung Koo on 29/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import DTOs
import RepositoryProtocols

public struct PlaceRepositoryMock: PlaceRepositoryProtocol {
	
	public typealias AppStatusService = AppStatusServiceMock
	public typealias Endpoint = EndPointMock

	public func getPlaces(request: GetPlacesRequest) async throws(GetPlacesError) -> GetPlacesResponse {
		throw .notFound
	}
	
	public func getPlace(request: GetPlaceRequest) async throws(GetPlaceError) -> GetPlaceResponse {
		throw .notFound
	}
	
	public func errorHandlerExceptNotFound(appStatusService: AppStatusService, error: NetworkErrorMock) async { }
	
}
