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

@main
struct MainApp: App {
	
	@StateObject var mainRouter = MainRouter()
	
  var body: some Scene {
    WindowGroup {
			NavigationStack {
				MainView(viewModel: MainFactory().resolve(), router: mainRouter)
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
    }
  }
}
