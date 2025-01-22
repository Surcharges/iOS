//
//  PlaceDetailFactory.swift
//  Factories
//
//  Created by Bonsung Koo on 17/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import FactoryProtocols

import Repositories
import UseCases
import ViewModels
import AppStatusService

public struct PlaceDetailFactory: PlaceDetailFactoryProtocol {
	
	public typealias ViewModel = PlaceDetailViewModel<GetPlaceUsecase<PlaceRepository<AppStatusService>>>
	
	private let _placeId: String
	
	public init(placeId: String) {
		_placeId = placeId
	}
	
	public func resolve(appStatusService: AppStatusService) -> ViewModel {
		return PlaceDetailViewModel(
			placeId: _placeId,
			getPlace: GetPlaceUsecase(
				placeRepository: PlaceRepository(
					appStatusService: appStatusService
				)
			)
		)
	}
	
}
