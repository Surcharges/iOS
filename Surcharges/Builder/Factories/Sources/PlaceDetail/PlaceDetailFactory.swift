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
import ViewUpdateService

public struct PlaceDetailFactory: PlaceDetailFactoryProtocol {
	
	public typealias ViewModel = PlaceDetailViewModel<
		GetPlaceUsecase<PlaceRepository<AppStatusService>>,
		ViewUpdateService
	>
	
	private let _placeId: String
	
	private let _viewUpdateService: ViewUpdateService
	
	public init(placeId: String, viewUpdateService: ViewUpdateService) {
		_placeId = placeId
		_viewUpdateService = viewUpdateService
	}
	
	public func resolve(appStatusService: AppStatusService) -> ViewModel {
		return PlaceDetailViewModel(
			placeId: _placeId,
			getPlace: GetPlaceUsecase(
				placeRepository: PlaceRepository(
					appStatusService: appStatusService
				)
			),
			viewUpdateService: _viewUpdateService
		)
	}
	
}
