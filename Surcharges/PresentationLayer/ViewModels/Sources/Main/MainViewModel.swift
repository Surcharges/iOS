//
//  MainViewModel.swift
//  ViewModels
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

import Models
import UseCaseProtocols
import ViewModelProtocols
import LocationServiceProtocol
import ViewUpdateServiceProtocol

public final class MainViewModel<
	GetPlace: GetPlacesUsecaseProtocol,
	LocationService: LocationServiceProtocol,
	ViewUpdateService: ViewUpdateServiceProtocol
>: BaseViewModel, MainViewModelProtocol {
	
	@Published public var mainModel: MainModel = .init(places: [], isExistNextPage: false)
	@Published public var searchText: String = ""
	@Published public var searchedText: String = ""
	@Published public var isLoading: Bool = false
	@Published public var noResults: Bool = false
	@Published public var canSearch: Bool = false
	@Published public var isDeniedToUseUserLocation: Bool = false
	@Published public var isUserLocationOn: Bool = false
	
	private var _locationAuthorisationStatus: CLAuthorizationStatus = .notDetermined
	private var _lastUserLocation: CLLocation?
	
	private var _cancellables: Set<AnyCancellable> = []
	
	private var _nextPageToken: String?
	
	private let _getPlaces: GetPlace
	private let _locationService: LocationService
	private let _viewUpdateService: ViewUpdateService
	
	public init(
		getPlaces: GetPlace,
		locationService: LocationService,
		viewUpdateService: ViewUpdateService
	) {
		_getPlaces = getPlaces
		_locationService = locationService
		_viewUpdateService = viewUpdateService
		
		super.init()
		
		_bindCanSearch()
		_bindIsDeniedToUseUserLocation()
		_bindViewUpdate()
	}
	
	public func search() async {
		
		_nextPageToken = nil
		isLoading = true
		
		var userLocation: Location?
		
		if isUserLocationOn, let location = try? await _locationService.getLocation() {
			_lastUserLocation = location
			userLocation = .init(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
		} else {
			_lastUserLocation = nil
		}
		
		let getPlacesResult = await _getPlaces.invoke(
			requestValue: .init(
				searchText: searchText,
				nextPageToken: _nextPageToken,
				userLocation: userLocation != nil ? .init(latitude: userLocation!.latitude, longitude: userLocation!.longitude) : nil
			)
		)
		
		isLoading = false
		searchedText = searchText
		
		switch getPlacesResult {
			
		case .success(let response):
			
			noResults = false
			
			let places = response.items.map { item -> Place in
				return  ConvertPlaceEntityToModel.convert(place: item.place, surcharge: item.surcharge)
			}
			
			mainModel = .init(places: places, isExistNextPage: response.nextPageToken != nil)
			
			_nextPageToken = response.nextPageToken
			
		case .failure(let error):
			switch error {
			case .noResults:
				noResults = true
				mainModel = .init(places: [], isExistNextPage: false)
			}
		}
		
	}
	
	public func next() async {
		
		var userLocation: Location?
		
		if let location = _lastUserLocation {
			userLocation = .init(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
		}
		
		let getPlacesResult = await _getPlaces.invoke(
			requestValue: .init(
				searchText: searchText,
				nextPageToken: _nextPageToken,
				userLocation: userLocation != nil ? .init(latitude: userLocation!.latitude, longitude: userLocation!.longitude) : nil
			)
		)
		
		switch getPlacesResult {
			
		case .success(let response):
			let places = response.items.map { item -> Place in
				return  ConvertPlaceEntityToModel.convert(place: item.place, surcharge: item.surcharge)
			}
			
			let newPlaces = mainModel.places + places
			
			mainModel = .init(places: newPlaces, isExistNextPage: response.nextPageToken != nil)
			
			_nextPageToken = response.nextPageToken
			
		case .failure:
			
			mainModel = .init(places: mainModel.places, isExistNextPage: false)
			
		}
		
	}
	
	public func toggleUserLocation() {
		
		switch _locationAuthorisationStatus {
		
		case .authorizedWhenInUse, .authorizedAlways:
			
			isUserLocationOn.toggle()
			
		case .notDetermined:
			
			_locationService.requestWhenInUseAuthorization()
			isUserLocationOn = true
			
		default:
			break
		}
		
	}
	
	private func _bindCanSearch() {
		Publishers.CombineLatest($searchText, $isLoading)
			.map { searchText, isLoading in
				return !searchText.isEmpty && !isLoading
			}
			.sink(receiveValue: { [weak self] canSearch in
				self?.canSearch = canSearch
			})
			.store(in: &_cancellables)
	}
	
	private func _bindIsDeniedToUseUserLocation() {
		
		_locationService.authorizationStatus
			.sink(receiveValue: { [weak self] status in
				
				switch status {
				case .authorizedWhenInUse, .authorizedAlways:
					self?.isDeniedToUseUserLocation = false
				case .notDetermined:
					self?.isDeniedToUseUserLocation = false
				default:
					self?.isDeniedToUseUserLocation = true
				}
				
				self?._locationAuthorisationStatus = status
				
			})
			.store(in: &_cancellables)
		
	}
	
	private func _bindViewUpdate() {
		_viewUpdateService
			.notified
			.sink { [weak self] viewUpdateType in
				switch viewUpdateType {
				case .surchargeInformationUpdated(let updatedPlace):
					
					let newPlaces = self?.mainModel.places.compactMap { _place -> Place? in
						if updatedPlace.id == _place.id {
							return .init(
								id: _place.id,
								name: _place.name,
								address: _place.address,
								location: _place.location,
								surcharge: updatedPlace.surcharge
							)
						}
						return _place
					}
					
					self?.mainModel = .init(places: newPlaces ?? [], isExistNextPage: self?.mainModel.isExistNextPage ?? false)
					
				}
			}
			.store(in: &_cancellables)
	}
}
