//
//  LocationService.swift
//  Services
//
//  Created by Bonsung Koo on 17/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation
import CoreLocation
import Combine

import ServiceProtocols

public final class LocationService: NSObject, LocationServiceProtocol, @preconcurrency CLLocationManagerDelegate {
	
	private let _locationManager = CLLocationManager()
	private var _continuation: CheckedContinuation<CLLocation, Error>?
	
	public var authorizationStatus = PassthroughSubject<CLAuthorizationStatus, Never>()
	
	public override init() {
		super.init()
		_locationManager.delegate = self
		_locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
	}
	
	public func requestWhenInUseAuthorization() {
		_locationManager.requestWhenInUseAuthorization()
	}
	
	public func getLocation() async throws(Error) -> CLLocation {
		guard CLLocationManager.locationServicesEnabled() else {
			throw CLError(.locationUnknown)
		}
		
		_locationManager.startUpdatingLocation()
		
		return try await withCheckedThrowingContinuation { continuation in
			_continuation = continuation
		}
	}
	
	public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		authorizationStatus.send(manager.authorizationStatus)
	}
	
	public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
		_locationManager.stopUpdatingLocation()
		
		if let location = locations.last {
			_continuation?.resume(returning: location)
		} else {
			_continuation?.resume(throwing: CLError(.locationUnknown))
		}
		
		_continuation = nil
		
	}
	
	public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		_locationManager.stopUpdatingLocation()
		_continuation?.resume(throwing: error)
		_continuation = nil
	}
	
}

