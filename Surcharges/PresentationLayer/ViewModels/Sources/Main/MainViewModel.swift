//
//  MainViewModel.swift
//  ViewModels
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation
import Combine

import Models
import UseCaseProtocols
import ViewModelProtocols

public final class MainViewModel<Usecase: GetPlacesUsecaseProtocol>: MainViewModelProtocol {
	
	@Published public var mainModel: MainModel = .init(places: [], isExistNextPage: false)
	@Published public var searchText: String = ""
	@Published public var searchedText: String = ""
	@Published public var isLoading: Bool = false
	@Published public var noResults: Bool = false
	@Published public var canSearch: Bool = false
	
	private var _cancellables: Set<AnyCancellable> = []
	
	private var _nextPageToken: String?
	private let _getPlaces: Usecase
	
	public init(getPlaces: Usecase) {
		_getPlaces = getPlaces
		
		_bindCanSearch()
	}
	
	public func search() async {
		
		_nextPageToken = nil
		isLoading = true
		
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
			case .noResult:
				noResults = true
				mainModel = .init(places: [], isExistNextPage: false)
			case .unknown:
				break
			}
		}
		
	}
	
	public func next() async {
		
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
}
