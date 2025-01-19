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

public struct PlaceDetailView<VM: PlaceDetailViewModelProtocol>: View {
	
	@EnvironmentObject var viewModel: VM
	@Environment(\.dismiss) var dismiss
	
	public init() { }
	
	public var body: some View {
		ZStack(alignment: .bottom) {
			
			ScrollView {
				
				VStack(spacing: 10) {
					
					ZStack(alignment: .topTrailing) {
						
						if viewModel.isLoading {
							
							MapLoadingView()
							
						} else {
							MapView(placeLocation: viewModel.placeLocation)
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
					placeName: viewModel.placeName,
					placeAddress: viewModel.placeAddress,
					surcharge: viewModel.surcharge,
					isLoading: viewModel.isLoading
				)
				
			}
			
			ContributeButton(surcharge: viewModel.surcharge)

		}
		.task {
			await viewModel.getPlaceDetail()
		}
	}
}
