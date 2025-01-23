//
//  PlaceDetailViewModel.swift
//  ViewModels
//
//  Created by Bonsung Koo on 17/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

import Models
import UseCaseProtocols
import ViewModelProtocols
import ViewUpdateServiceProtocol

public final class PlaceDetailViewModel<
	GetPlace: GetPlaceUsecaseProtocol,
	ViewUpdateService: ViewUpdateServiceProtocol
>: BaseViewModel, PlaceDetailViewModelProtocol {
	
	@Published public var placeName: String = "A name of place"
	@Published public var placeAddress: String = "An address of place"
	@Published public var placeLocation: Location = .init(latitude: 0, longitude: 0)
	@Published public var surcharge: Surcharge = .init(status: .notDetermined, rate: nil, updatedDate: nil)
	@Published public var isLoading: Bool = true
	
	private var _cancellables: Set<AnyCancellable> = []
	
	public let placeId: String
	
	private let _getPlace: GetPlace
	private let _viewUpdateService: ViewUpdateService
	
	public init(placeId: String, getPlace: GetPlace, viewUpdateService: ViewUpdateService) {
		self.placeId = placeId
		_getPlace = getPlace
		_viewUpdateService = viewUpdateService
		super.init()
		
		_bindViewUpdate()
	}
	
	public func getPlaceDetail() async {
		
		isLoading = true
		
		do {
			
			let getPlaceResult = try await _getPlace.invoke(requestValue: .init(placeId: placeId))
			
			let place = ConvertPlaceEntityToModel.convert(place: getPlaceResult.place, surcharge: getPlaceResult.surcharge)
			
			placeName = place.name
			placeAddress = place.address
			placeLocation = place.location ?? .init(latitude: 0, longitude: 0)
			surcharge = place.surcharge
			
		} catch (let error) {
			switch error {
			case .notFound:
				break
			}
		}
		
		isLoading = false
	}
	
	private func _bindViewUpdate() {
		_viewUpdateService
			.notified
			.sink { [weak self] viewUpdateType in
				switch viewUpdateType {
				case .surchargeInformationUpdated(let place):
					
					self?.surcharge = place.surcharge
					
				}
			}
			.store(in: &_cancellables)
	}
	
}
