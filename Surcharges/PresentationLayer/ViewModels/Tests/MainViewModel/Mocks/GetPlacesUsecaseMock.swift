//
//  GetPlacesUsecaseMock.swift
//  ViewModelsTests
//
//  Created by Bonsung Koo on 29/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import UseCaseProtocols
import Entities

struct GetPlacesUsecaseMock: GetPlacesUsecaseProtocol {
	func invoke(requestValue: GetPlacesRequest) async throws(GetPlacesError) -> GetPlacesResponse {
		return .init(
			items: [
				.init(
					place: .init(
						id: "id",
						displayName: .init(text: "displayName", languageCode: "en"),
						addressComponents: [],
						location: nil
					),
					surcharge: .init(status: .unknown, rate: nil, updatedDate: nil)
				)
			],
			nextPageToken: nil
		)
	}
}
