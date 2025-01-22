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

public final class PlaceDetailViewModel<GetPlace: GetPlaceUsecaseProtocol>: BaseViewModel, PlaceDetailViewModelProtocol {
	
	@Published public var placeName: String = "A name of place"
	@Published public var placeAddress: String = "An address of place"
	@Published public var placeLocation: Location = .init(latitude: 0, longitude: 0)
	@Published public var surcharge: Surcharge = .init(status: .notDetermined, rate: nil, updatedDate: nil)
	@Published public var isLoading: Bool = true
	
	public let placeId: String
	
	private let _getPlace: GetPlace
	
	public init(placeId: String, getPlace: GetPlace) {
		self.placeId = placeId
		_getPlace = getPlace
		
		super.init()
	}
	
	public func getPlaceDetail() async {
		
		isLoading = true
		
		let getPlaceResult = await _getPlace.invoke(requestValue: .init(placeId: placeId))
		
		switch getPlaceResult {
		case .success(let response):
			
			placeLocation = .init(
				latitude: response.place.location?.latitude ?? 0,
				longitude: response.place.location?.longitude ?? 0
			)
			
			placeName = response.place.displayName.text
			placeAddress = response.place.addressComponents.prefix(4).map { $0.longText }.joined(separator: " ")
			
			var surchargeStatus: SurchargeStatus {
				switch response.surcharge.status {
				case .unknown: return .unknown
				case .reported: return .reported
				case .confirmed: return .confirmed
				}
			}
			
			var updatedDate: Date? {
				guard let updatedDate = response.surcharge.updatedDate else { return nil }
				return Date(timeIntervalSince1970: TimeInterval(updatedDate.seconds))
			}
			
			surcharge = .init(status: surchargeStatus, rate: response.surcharge.rate, updatedDate: updatedDate)
			
		case .failure:
			break
		}
		
		isLoading = false
		
	}
	
}
