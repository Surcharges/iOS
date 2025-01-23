import SwiftUI

import Factories
import Main
import PlaceDetail
import ReportSurcharge
import MainRouter
import PlaceDetailRouter
import ReportSurchargeRouter
import AppStatusService
import LocationService
import ViewUpdateService

import ToastUI

@main
struct SurchargesApp: App {
	
	@StateObject private var _mainRouter = MainRouter()
	@StateObject private var _placeDetailRouter = PlaceDetailRouter()
	@StateObject private var _reportSurchargeRouter = ReportSurchargeRouter()
	
	private let _locationService = LocationService()
	@StateObject private var _viewUpdateService: ViewUpdateService
	@StateObject private var _appStatusService = AppStatusService()
	
	private let _mainFactory: MainFactory
	
	init() {
		let viewUpateService = ViewUpdateService()
		__viewUpdateService = StateObject(wrappedValue: viewUpateService)
		_mainFactory = .init(locationService: _locationService, viewUpdateService: viewUpateService)
	}
	
	var body: some Scene {
		WindowGroup {
			
			NavigationStack {
				
				MainView(
					viewModel: _mainFactory.resolve(appStatusService: _appStatusService),
					router: _mainRouter
				)
				.sheet(item: $_mainRouter.activeSheet) { destination in
					
					switch destination {
					case .placeDetail(let placeId):
						
						PlaceDetailView(
							viewModel: PlaceDetailFactory(placeId: placeId, viewUpdateService: _viewUpdateService)
								.resolve(appStatusService: _appStatusService),
							router: _placeDetailRouter
						)
						.sheet(item: $_placeDetailRouter.activeSheet) { destination in
							
							switch destination {
							case .reportSurchargeInformation(let placeId, let placeName):
								
								ReportSurchargeView(
									viewModel: ReportSurchargeFactory(
										placeId: placeId,
										placeName: placeName,
										viewUpdateService: _viewUpdateService
									).resolve(appStatusService: _appStatusService),
									router: _reportSurchargeRouter
								)
								
							}
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
