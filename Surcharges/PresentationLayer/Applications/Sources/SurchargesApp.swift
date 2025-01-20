import SwiftUI

import Factories
import Main
import PlaceDetail
import MainRouter
import PlaceDetailRouter

@main
struct SurchargesApp: App {
	
	@StateObject var mainRouter = MainRouter()
	@StateObject var placeDetailRouter = PlaceDetailRouter()
	
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
									case .reportSurchargeInformation(let id):
									
										VStack {
											Text("Report Surcharge Information View")
										}
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
