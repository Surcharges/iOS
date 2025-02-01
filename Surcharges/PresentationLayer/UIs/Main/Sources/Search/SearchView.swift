//
//  SearchView.swift
//  Main
//
//  Created by Bonsung Koo on 01/02/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import Resources
import ViewModelProtocols

struct SearchView<VM: MainViewModelProtocol>: View {
	
	private let _useLocationTip = UseLocationTip()
	@State private var _showLocationDeniedAlert = false
	@StateObject private var _viewModel: VM
	
	@FocusState private var _isSearchTextFeildFocused: Bool
	
	init(viewModel: StateObject<VM>) {
		__viewModel = viewModel
	}
	
	var body: some View {
		HStack(spacing: 10) {
			
			Button {
				
				if _viewModel.isDeniedToUseUserLocation {
					_showLocationDeniedAlert.toggle()
				} else {
					
					withAnimation {
						_viewModel.toggleUserLocation()
					}
					
					_useLocationTip.invalidate(reason: .actionPerformed)
					
				}
				
			} label: {
				
				if _viewModel.isDeniedToUseUserLocation {
					Image(systemName: "location.slash")
						.foregroundStyle(R.color.blue600.color)
				} else {
					Image(systemName: _viewModel.isUserLocationOn ? "location.fill" : "location")
						.foregroundStyle(R.color.blue600.color)
				}
				
			}
			.buttonStyle(.plain)
			.contentTransition(.symbolEffect(.replace))
			.alert(
				R.string.localizable.alertUseLocationDeniedTitle(),
				isPresented: $_showLocationDeniedAlert
			) {
				
				Button {
					
					UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
					
				} label: {
					Text(R.string.localizable.goToSettings())
				}
				
				Button(role: .cancel) {
					_showLocationDeniedAlert.toggle()
				} label: {
					Text(R.string.localizable.close())
				}
				
			} message: {
				Text(R.string.localizable.alertUseLocationDeniedMessage())
			}
			.popoverTip(_useLocationTip, arrowEdge: .leading) { action in
				withAnimation {
					_viewModel.toggleUserLocation()
				}
				_useLocationTip.invalidate(reason: .actionPerformed)
			}
			
			TextField(R.string.localizable.searchBoxPlaceholder(), text: $_viewModel.searchText)
				.textFieldStyle(.roundedBorder)
				.font(.body)
				.disabled(_viewModel.isLoading)
				.onSubmit {
					
					if _viewModel.canSearch {
						Task {
							await _viewModel.search()
						}
					}
					
				}
				.submitLabel(.search)
				.focused($_isSearchTextFeildFocused)
				.onChange(of: _isSearchTextFeildFocused, { _, newValue in
					if newValue {
						UseLocationTip.tryToSearch.toggle()
					}
				})
			
			Button {
				
				Task {
					await _viewModel.search()
				}
				
			} label: {
				Text(R.string.localizable.searchButtonTitle())
					.font(.body)
					.disabled(!_viewModel.canSearch)
			}
			
		}
	}
}
