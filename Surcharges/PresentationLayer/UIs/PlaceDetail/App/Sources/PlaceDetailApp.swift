//
//  PlaceDetailApp.swift
//  PlaceDetailDemo
//
//  Created by Bonsung Koo on 17/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import PlaceDetail
import Factories
import ViewModels

@main
struct PlaceDetailApp: App {
	
	@State private var _isShowPlaceDetail = false
	
	private let _starbucksLambtonQuey = "ChIJ__-_U9SvOG0RNehxHQPATv0"
	
	var body: some Scene {
		WindowGroup {
			VStack {
				Button {
					_isShowPlaceDetail.toggle()
				} label: {
					Text("Open place")
				}
			}
			.sheet(isPresented: $_isShowPlaceDetail) {
				PlaceDetailView<PlaceDetailViewModel>()
					.environmentObject(PlaceDetailFactory(placeId: _starbucksLambtonQuey).resolve())
			}
		}
	}
}
