//
//  MainApp.swift
//  MainDemo
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI
import TipKit

import Main
import Factories
import MainRouter
import Toast

import LocationService
import AppStatusService
import AppStatusService
import ViewUpdateService
import DevelopmentEndpoint
import DevelopmentAdsService

@main
struct MainApp: App {
	
	@StateObject var mainRouter = MainRouter()
	
	private var _locationService = LocationService()
	@StateObject private var _appStatusService = AppStatusService()
	@StateObject private var _viewUpdateService = ViewUpdateService()
	
	var body: some Scene {
		WindowGroup {
			NavigationStack {
				MainView<MainFactory<DevelopmentEndpoint>.ViewModel, MainRouter, DevelopmentAdsService>(
					viewModel: MainFactory<DevelopmentEndpoint>(
						locationService: _locationService,
						viewUpdateService: _viewUpdateService
					)
					.resolve(appStatusService: _appStatusService),
					router: mainRouter
				)
				.sheet(item: $mainRouter.activeSheet) { destination in
					switch destination {
					case .placeDetail(let id):
						VStack {
							Text("Place Detail View")
							
							Text("Place ID: \(id)")
						}
						
					case .surchargeStatusHelp:
						
						VStack {
							Text("Surcharge Status Help View")
						}
						
					}
				}
			}
			.appStatusToast(appStatus: $_appStatusService.appStatus, dismissAfter: 5)
			
		}
	}
}
