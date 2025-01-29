//
//  MainViewModel.swift
//  ViewModelsTests
//
//  Created by Bonsung Koo on 29/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation
import Testing

import ViewUpdateServiceProtocol
import ViewModels

@MainActor
struct MainViewModelTests {
	
	let mainViewModel = MainViewModel(
		getPlaces: GetPlacesUsecaseMock(),
		locationService: LocationServiceMock(),
		viewUpdateService: ViewUpdateServiceMock()
	)
	
	@Test("Places count must 1")
	func mainViewModel() async throws {
		await mainViewModel.search()
		
		#expect(mainViewModel.mainModel.places.count == 1)
	}
	
}
