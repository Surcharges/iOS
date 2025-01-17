//
//  PlaceDetailViewModelProtocol.swift
//  ViewModelProtocols
//
//  Created by Bonsung Koo on 17/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import Models

public protocol PlaceDetailViewModelProtocol: ViewModelProtocol {
	var placeName: String { get set }
	var placeAddress: String { get set }
}
