//
//  PlaceDetailView.swift
//  PlaceDetailDemo
//
//  Created by Bonsung Koo on 17/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI
import MapKit

import Resources
import CommonUI

import ViewModelProtocols
import RouterProtocols

public struct PlaceDetailView<VM: PlaceDetailViewModelProtocol, Router: PlaceDetailRouterProtocol>: View {
	
	@StateObject private var _viewModel: VM
	@StateObject private var _router: Router
	
	@Environment(\.dismiss) var dismiss
	
	public init(viewModel: VM, router: Router) {
		__viewModel = StateObject(wrappedValue: viewModel)
		__router = StateObject(wrappedValue: router)
	}
	
	public var body: some View {
		ZStack(alignment: .bottom) {
			
			ScrollView {
				
				VStack(spacing: 10) {
					
					ZStack(alignment: .topTrailing) {
						
						if _viewModel.isLoading {
							
							MapLoadingView()
							
						} else {
							MapView(placeLocation: _viewModel.placeLocation)
						}
						
						Button {
							
							dismiss()
							
						} label: {
							
							Image(systemName: "xmark.circle.fill")
								.foregroundStyle(R.color.gray500.color)
								.font(.largeTitle)
							
						}
						.padding([.top, .trailing], 10)
						
					}
					.aspectRatio(1/1, contentMode: .fit)
					
				}
				
				SurchargeView(
					placeName: _viewModel.placeName,
					placeAddress: _viewModel.placeAddress,
					surcharge: _viewModel.surcharge,
					isLoading: _viewModel.isLoading
				)
				
			}
			
			ContributeButton(surcharge: _viewModel.surcharge) {
				_router.present(.reportSurchargeInformation(id: _viewModel.placeId))
			}

		}
		.task {
			await _viewModel.getPlaceDetail()
		}
	}
}
