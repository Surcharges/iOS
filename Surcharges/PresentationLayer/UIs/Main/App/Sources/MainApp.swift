//
//  MainApp.swift
//  MainDemo
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import Main
import Factories

import Repositories
import UseCases

@main
struct MainApp: App {
  var body: some Scene {
    WindowGroup {
      MainView(viewModel: MainFactory.resolve())
				.task {
					let result = await GetPlacesUsecase(placeRepository: PlaceRepository()).invoke(requestValue: .init(searchText: "starbucks", nextPageToken: nil))
					
					switch result {
					case .success(let response):
						
						print(response)
					case .failure:
						break
					}
				}
    }
  }
}
