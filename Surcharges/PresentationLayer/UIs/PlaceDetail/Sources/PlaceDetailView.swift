//
//  PlaceDetailView.swift
//  PlaceDetailDemo
//
//  Created by Bonsung Koo on 17/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import Resources
import CommonUI

import ViewModelProtocols

public struct PlaceDetailView<VM: PlaceDetailViewModelProtocol>: View {
	
	@EnvironmentObject var viewModel: VM
//	@ObservedObject private var _viewModel: VM
//	
//	public init(viewModel: VM) {
//		_viewModel = viewModel
//	}
	
	public var body: some View {
		
		VStack(spacing: 0) {
			Text("Place Detail")
			
			Text(viewModel.placeName)
			Text(viewModel.placeAddress)
		}
		
	}
}
