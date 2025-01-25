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
import LocationService
import ViewUpdateService
import EndpointProtocol

public struct MainFactory<Endpoint: EndpointProtocol>: MainFactoryProtocol {
		
	public typealias ViewModel = MainViewModel<
		GetPlacesUsecase<PlaceRepository<AppStatusService, Endpoint>>,
		LocationService,
		ViewUpdateService
	>
	
	private let _locationService: LocationService
	private let _viewUpdateService: ViewUpdateService
	
	public init(locationService: LocationService, viewUpdateService: ViewUpdateService) {
		_locationService = locationService
		_viewUpdateService = viewUpdateService
	}
	
	public func resolve(appStatusService: AppStatusService) -> ViewModel {
		
		return MainViewModel(
			getPlaces: GetPlacesUsecase(
				placeRepository: PlaceRepository(
					appStatusService: appStatusService
				)
			),
			locationService: _locationService,
			viewUpdateService: _viewUpdateService
		)
	}
	
}
