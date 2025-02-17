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
import AppStatusService
import ViewUpdateService
import DevelopmentEndpoint
import Toast

@main
struct PlaceDetailApp: App {
	
	@StateObject private var _placeDetailRouter = PlaceDetailRouter()
	@StateObject private var _appStatusService = AppStatusService()
	@StateObject private var _viewUpdateService = ViewUpdateService()
	
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
				.sheet(isPresented: $_isShowStarbucksLambtonQuey) {
					PlaceDetailView<PlaceDetailFactory<DevelopmentEndpoint>.ViewModel, PlaceDetailRouter>(
						viewModel: PlaceDetailFactory(
							placeId: _starbucksLambtonQuey,
							viewUpdateService: _viewUpdateService
						).resolve(appStatusService: _appStatusService),
						router: _placeDetailRouter
					)
					.sheet(item: $_placeDetailRouter.activeSheet) { destination in
						switch destination {
						case .reportSurchargeInformation(let placeId, let placeName):
							VStack {
								Text("Report Surcharge Information View")
								
								Text("Place ID: \(placeId)")
								Text("Place name: \(placeName)")
							}
						}
					}
				}
				
				Button {
					_isShowStarbucksLowerHutt.toggle()
				} label: {
					Text("Starbucks Lower Hutt")
				}
				.sheet(isPresented: $_isShowStarbucksLowerHutt) {
					PlaceDetailView<PlaceDetailFactory<DevelopmentEndpoint>.ViewModel, PlaceDetailRouter>(
						viewModel: PlaceDetailFactory(
							placeId: _starbucksLowerHutt,
							viewUpdateService: _viewUpdateService
						).resolve(appStatusService: _appStatusService),
						router: _placeDetailRouter
					)
					.sheet(item: $_placeDetailRouter.activeSheet) { destination in
						switch destination {
						case .reportSurchargeInformation(let placeId, let placeName):
							VStack {
								Text("Report Surcharge Information View")
								
								Text("Place ID: \(placeId)")
								Text("Place name: \(placeName)")
							}
						}
					}
				}
				
			}
			.appStatusToast(appStatus: $_appStatusService.appStatus, dismissAfter: 5)
			
		}
	}
}
