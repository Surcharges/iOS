//
//  PlacesView.swift
//  Main
//
//  Created by Bonsung Koo on 16/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import CommonUI
import Resources

import Models

struct PlacesView: View {
	
	@Binding private var _mainModel: MainModel
	private let _loadNextPage: () -> Void
	private let _selectedPlace: (String) -> Void
	
	init(
		mainModel: Binding<MainModel>,
		selectedPlace: @escaping (String) -> Void,
		loadNextPage: @escaping () -> Void
	) {
		__mainModel = mainModel
		_selectedPlace = selectedPlace
		_loadNextPage = loadNextPage
	}
	
	var body: some View {
		ForEach(_mainModel.places) { place in
			
			Button {
				
				_selectedPlace(place.id)
				
			} label: {
				PlaceView(place: place)
			}
			.buttonStyle(.plain)
			
		}
		.padding(.bottom, 20)
		
		
		if _mainModel.isExistNextPage {
			CircleProgress()
				.onAppear {
					_loadNextPage()
				}
		}
			
	}
}

#Preview {
	PlacesView(
		mainModel: .constant(
			.init(
				places: [
					.init(
						id: "1",
						name: "Starbucks Porirua",
						address: "11 Hartham Pl North Porirua Porirua 5022 New Zealand",
						location: nil,
						surcharge: .init(status: .unknown, rate: nil, updatedDate: nil)
					),
					.init(
						id: "2",
						name: "Starbucks Lambton Quay",
						address: "233 Lambton Quay Wellington Central Wellington 6011 New Zealand",
						location: nil,
						surcharge: .init(status: .reported, rate: 0, updatedDate: Date())
					),
					.init(
						id: "3",
						name: "Starbucks Lower Hutt",
						address: "6 Bunny St Hutt Central Lower Hutt 5010 New Zealand",
						location: nil,
						surcharge: .init(status: .confirmed, rate: 1, updatedDate: Date())
					)
				]
				,
				isExistNextPage: false
			)
		),
		selectedPlace: { _ in
			
		},
		loadNextPage: { }
	)
}
