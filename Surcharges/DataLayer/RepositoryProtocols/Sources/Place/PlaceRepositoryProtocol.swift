//
//  PlaceRepositoryProtocol.swift
//  RepositoryProtocols
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import DTOs

public protocol PlaceRepositoryProtocol: RepositoryProtocol {
	func getPlaces(request: GetPlacesRequest) async -> GetPlacesResponse
	func getPlace(request: GetPlaceRequest) async -> Result<GetPlaceResponse, ResponseError>
}
