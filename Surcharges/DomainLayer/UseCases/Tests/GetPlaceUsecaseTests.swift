//
//  GetPlaceUsecaseTests.swift
//  UseCasesTests
//
//  Created by Bonsung Koo on 29/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation
import Testing

import Entities
import UseCases

@Test("GetPlaces")
func getPlaces() async throws {
	await #expect(throws: GetPlacesError.noResults) {
		try await GetPlacesUsecase(placeRepository: PlaceRepositoryMock())
			.invoke(requestValue: .init(searchText: "", nextPageToken: nil, userLocation: nil))
	}
}
