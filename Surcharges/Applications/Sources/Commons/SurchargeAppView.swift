//
//  SurchargeAppView.swift
//  Applications
//
//  Created by Bonsung Koo on 25/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

// Standard Frameworks
import SwiftUI
import TipKit

// UIs
import Main
import PlaceDetail
import ReportSurcharge
import SurchargeStatusHelp
import Toast

// Routers
import MainRouter
import PlaceDetailRouter
import ReportSurchargeRouter

// Builders
import Factories

// Services
import AppStatusService
import LocationService
import ViewUpdateService
import AdsServiceProtocol

// Endpoint
import EndpointProtocol

public struct SurchargeAppView<Endpoint: EndpointProtocol, AdsService: AdsServiceProtocol>: View {
	
	@StateObject private var _mainRouter = MainRouter()
	@StateObject private var _placeDetailRouter = PlaceDetailRouter()
	@StateObject private var _reportSurchargeRouter = ReportSurchargeRouter()
	
	private let _locationService = LocationService()
	@StateObject private var _viewUpdateService: ViewUpdateService
	@StateObject private var _appStatusService = AppStatusService()
	
	private let _mainFactory: MainFactory<Endpoint>
	
	init() {
		let viewUpateService = ViewUpdateService()
		__viewUpdateService = StateObject(wrappedValue: viewUpateService)
		_mainFactory = .init(locationService: _locationService, viewUpdateService: viewUpateService)
	}
	
	public var body: some View {
		
		NavigationStack {
			
			MainView<MainFactory<Endpoint>.ViewModel, MainRouter, AdsService>(
				viewModel: _mainFactory.resolve(appStatusService: _appStatusService),
				router: _mainRouter
			)
			.sheet(item: $_mainRouter.activeSheet) { destination in
				
				switch destination {
				case .placeDetail(let placeId):
					
					PlaceDetailView(
						viewModel: PlaceDetailFactory<Endpoint>(placeId: placeId, viewUpdateService: _viewUpdateService)
							.resolve(appStatusService: _appStatusService),
						router: _placeDetailRouter
					)
					.sheet(item: $_placeDetailRouter.activeSheet) { destination in
						
						switch destination {
						case .reportSurchargeInformation(let placeId, let placeName):
							
							ReportSurchargeView(
								viewModel: ReportSurchargeFactory<Endpoint>(
									placeId: placeId,
									placeName: placeName,
									viewUpdateService: _viewUpdateService
								).resolve(appStatusService: _appStatusService),
								router: _reportSurchargeRouter
							)
							
						}
					}
					
				case .surchargeStatusHelp:
					SurchargeStatusHelpView()
				}
			}
		}
		.appStatusToast(appStatus: $_appStatusService.appStatus, dismissAfter: 5)
		
	}
}
