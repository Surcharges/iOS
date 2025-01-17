//
//  LocationServiceProtocol.swift
//  ServiceProtocols
//
//  Created by Bonsung Koo on 17/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation
import CoreLocation
import Combine

@MainActor
public protocol LocationServiceProtocol {
	var authorizationStatus: PassthroughSubject<CLAuthorizationStatus, Never> { get }
	
	func getLocation() async throws -> CLLocation
	func requestWhenInUseAuthorization()
}
