import SwiftUI

import Factories
import Main
import PlaceDetail
import ReportSurcharge
import MainRouter
import PlaceDetailRouter
import ReportSurchargeRouter

@main
struct SurchargesApp: App {
	
	@StateObject var mainRouter = MainRouter()
	@StateObject var placeDetailRouter = PlaceDetailRouter()
	@StateObject var reportSurchargeRouter = ReportSurchargeRouter()
	
	var body: some Scene {
		WindowGroup {
			
			NavigationStack {
				
				MainView(viewModel: MainFactory().resolve(), router: mainRouter)
					.sheet(item: $mainRouter.activeSheet) { destination in
						
						switch destination {
						case .placeDetail(let placeId):
							
							PlaceDetailView(viewModel: PlaceDetailFactory(placeId: placeId).resolve(), router: placeDetailRouter)
								.sheet(item: $placeDetailRouter.activeSheet) { destination in
									
									switch destination {
									case .reportSurchargeInformation(let placeId, let placeName):
									
										ReportSurchargeView(
											viewModel: ReportSurchargeFactory(placeId: placeId, placeName: placeName).resolve(),
											router: reportSurchargeRouter
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
			
		}
	}
}
