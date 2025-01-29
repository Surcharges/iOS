//
//  LocationServiceMock.swift
//  ViewModelsTests
//
//  Created by Bonsung Koo on 29/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

import LocationServiceProtocol

struct LocationServiceMock: LocationServiceProtocol {
	var authorizationStatus = PassthroughSubject<CLAuthorizationStatus, Never>()
	
	func getLocation() async throws -> CLLocation {
		return .init(latitude: 0, longitude: 0)
	}
	
	func requestWhenInUseAuthorization() { }
	
	
}
