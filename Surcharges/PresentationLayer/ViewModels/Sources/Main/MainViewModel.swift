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
import ServiceProtocols

public final class MainViewModel<
	GetPlace: GetPlacesUsecaseProtocol,
	LocationService: LocationServiceProtocol
>: MainViewModelProtocol {
	
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
	
	public init(
		getPlaces: GetPlace,
		locationService: LocationService
	) {
		_getPlaces = getPlaces
		_locationService = locationService
		
		_bindCanSearch()
		_bindIsDeniedToUseUserLocation()
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
		
		print(userLocation ?? "No location")
		
		let getPlacesResult = await _getPlaces.invoke(requestValue: .init(searchText: searchText, nextPageToken: _nextPageToken))
		
		isLoading = false
		searchedText = searchText
		
		switch getPlacesResult {
			
		case .success(let response):
			
			noResults = false
			
			let places = response.items.map { item -> Place in
				
				var surchargeStatus: SurchargeStatus {
					switch item.surcharge.status {
					case .unknown: return .unknown
					case .reported: return .reported
					case .confirmed: return .confirmed
					}
				}
				
				return .init(
					id: item.place.id,
					name: item.place.displayName.text,
					address: item.place.addressComponents.prefix(4).map { $0.longText }.joined(separator: " "),
					location: nil,
					surcharge: .init(status: surchargeStatus, rate: item.surcharge.rate)
				)
			}
			
			mainModel = .init(places: places, isExistNextPage: response.nextPageToken != nil)
			
			_nextPageToken = response.nextPageToken
			
		case .failure(let error):
			switch error {
			case .noResults:
				noResults = true
				mainModel = .init(places: [], isExistNextPage: false)
			case .unknown:
				break
			}
		}
		
	}
	
	public func next() async {
		
		var userLocation: Location?
		
		if isUserLocationOn, let location = _lastUserLocation {
			userLocation = .init(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
		}
		
		print(userLocation ?? "No location")
		
		let getPlacesResult = await _getPlaces.invoke(requestValue: .init(searchText: searchText, nextPageToken: _nextPageToken))
		
		switch getPlacesResult {
			
		case .success(let response):
			let places = response.items.map { item -> Place in
				
				var surchargeStatus: SurchargeStatus {
					switch item.surcharge.status {
					case .unknown: return .unknown
					case .reported: return .reported
					case .confirmed: return .confirmed
					}
				}
				
				return .init(
					id: item.place.id,
					name: item.place.displayName.text,
					address: item.place.addressComponents.map { $0.longText }.joined(separator: " "),
					location: nil,
					surcharge: .init(status: surchargeStatus, rate: item.surcharge.rate)
				)
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
}
