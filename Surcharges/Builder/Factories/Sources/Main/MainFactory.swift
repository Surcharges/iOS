//
//  MainFactory.swift
//  Factories
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import FactoryProtocols

import Repositories
import UseCases
import ViewModels
import AppStatusService
import AppStatusServiceProtocol
import LocationService

public struct MainFactory: MainFactoryProtocol {
		
	public typealias ViewModel = MainViewModel<
		GetPlacesUsecase<PlaceRepository<AppStatusService>>,
		LocationService
	>
	
	private let _locationService: LocationService
	
	public init(locationService: LocationService) {
		_locationService = locationService
	}
	
	public func resolve(appStatusService: AppStatusService) -> ViewModel {
		
		return MainViewModel(
			getPlaces: GetPlacesUsecase(
				placeRepository: PlaceRepository(
					appStatusService: appStatusService
				)
			),
			locationService: _locationService
		)
	}
	
}
