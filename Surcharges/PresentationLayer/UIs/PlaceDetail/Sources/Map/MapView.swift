//
//  MapView.swift
//  PlaceDetailDemo
//
//  Created by Bonsung Koo on 18/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI
import MapKit

import Models

struct MapView: View {
	
	@State private var _cameraPosition: MapCameraPosition
	@State private var _placeCoordinate: CLLocationCoordinate2D
	
	private var _placeLocation: Location
	
	init(placeLocation: Location) {
		_placeLocation = placeLocation
		_cameraPosition = .camera(.init(centerCoordinate: placeLocation.coordinate, distance: 500))
		_placeCoordinate = placeLocation.coordinate
	}
	
	var body: some View {
		
		Map(position: $_cameraPosition) {
			Marker(
				"",
				coordinate: _placeCoordinate
			)
		}
		.onChange(of: _placeLocation, { oldValue, newValue in
			withAnimation {
				_cameraPosition = .camera(.init(centerCoordinate: newValue.coordinate, distance: 500))
				_placeCoordinate = newValue.coordinate
				print(newValue.coordinate)
			}
		})
		
	}
}
