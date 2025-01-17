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

public final class PlaceDetailViewModel: PlaceDetailViewModelProtocol {
	
	@Published public var placeName: String = ""
	@Published public var placeAddress: String = ""
	
	private var _placeId: String
	
	public init(placeId: String) {
		_placeId = placeId
		
		placeName = "starbucks"
	}
	
}
