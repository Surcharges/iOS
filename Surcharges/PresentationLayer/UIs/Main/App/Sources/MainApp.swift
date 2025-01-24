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

import LocationService
import AppStatusService
import AppStatusService
import ViewUpdateService
import DevelopmentEndpoint

import ToastUI

@main
struct MainApp: App {
	
	@StateObject var mainRouter = MainRouter()
	
	private var _locationService = LocationService()
	@StateObject private var _appStatusService = AppStatusService()
	@StateObject private var _viewUpdateService = ViewUpdateService()
	
	var body: some Scene {
		WindowGroup {
			NavigationStack {
				MainView(
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
			.toast(item: $_appStatusService.appStatus, dismissAfter: 5) { status in
				switch status {
				case .toast(let type):
					switch type {
					case .notAuthorized:
						ToastView("Do you want some permissions?😁")
							.toastViewStyle(.failure)
					case .outOfNZ:
						ToastView("🇳🇿Only available in New Zealand.")
							.toastViewStyle(.information)
					case .noInternet:
						ToastView("🛜Please check the Internet connection.")
							.toastViewStyle(.warning)
					case .needToUpdate:
						ToastView("🔥New version available. Please update.")
							.toastViewStyle(.information)
					case .unknown(let message):
						ToastView("Oops🫢 Something went wrong. Please try again.\n\(message)")
							.toastViewStyle(.failure)
					}
				}
			}
			.toastDimmedBackground(false)
		}
	}
}
