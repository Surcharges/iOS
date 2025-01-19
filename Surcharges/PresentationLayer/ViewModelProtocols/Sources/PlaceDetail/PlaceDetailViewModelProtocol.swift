//
//  PlaceDetailViewModelProtocol.swift
//  ViewModelProtocols
//
//  Created by Bonsung Koo on 17/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation
import Combine

import Models

public protocol PlaceDetailViewModelProtocol: ViewModelProtocol {
	var placeName: String { get }
	var placeAddress: String { get }
	var placeLocation: Location { get }
	var surcharge: Surcharge { get }
	
	var isLoading: Bool { get }
	
	func getPlaceDetail() async
}
