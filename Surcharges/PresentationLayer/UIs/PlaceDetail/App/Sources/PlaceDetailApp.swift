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
import PlaceDetailRouter

@main
struct PlaceDetailApp: App {
	
	@StateObject var placeDetailRouter = PlaceDetailRouter()
	
	@State private var _isShowStarbucksLambtonQuey = false
	@State private var _isShowStarbucksLowerHutt = false
	
	private let _starbucksLambtonQuey = "ChIJ__-_U9SvOG0RNehxHQPATv0"
	private let _starbucksLowerHutt = "ChIJTbxdbFaqOG0Rt5u-D2CPNiE"
	
var body: some Scene {
		WindowGroup {
			VStack(spacing: 30) {
				Button {
					_isShowStarbucksLambtonQuey.toggle()
				} label: {
					Text("Starbucks Lambton Quay")
				}
				
				Button {
					_isShowStarbucksLowerHutt.toggle()
				} label: {
					Text("Starbucks Lower Hutt")
				}
			}
			.sheet(isPresented: $_isShowStarbucksLambtonQuey) {
				PlaceDetailView<PlaceDetailFactory.ViewModel, PlaceDetailRouter>(
					viewModel: PlaceDetailFactory(placeId: _starbucksLambtonQuey).resolve(),
					router: placeDetailRouter
				)
				.sheet(item: $placeDetailRouter.activeSheet) { destination in
					switch destination {
					case .reportSurchargeInformation(let id):
						VStack {
							Text("Report Surcharge Information View")
							
							Text("Place ID: \(id)")
						}
					}
				}
			}
			.sheet(isPresented: $_isShowStarbucksLowerHutt) {
				PlaceDetailView<PlaceDetailFactory.ViewModel, PlaceDetailRouter>(
					viewModel: PlaceDetailFactory(placeId: _starbucksLowerHutt).resolve(),
					router: placeDetailRouter
				)
				.sheet(item: $placeDetailRouter.activeSheet) { destination in
					switch destination {
					case .reportSurchargeInformation(let id):
						VStack {
							Text("Report Surcharge Information View")
							
							Text("Place ID: \(id)")
						}
					}
				}
			}
			
		}
	}
}
