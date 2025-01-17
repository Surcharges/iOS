//
//  MainView.swift
//  Main
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI
import TipKit

import Resources
import CommonUI

import ViewModelProtocols

public struct MainView<VM: MainViewModelProtocol>: View {
	
	@ObservedObject var viewModel: VM
	
	private let _surchargeStatusTip = SurchargeStatusTip()
	private let _useLocationTip = UseLocationTip()
	@State private var _showLocationDeniedAlert = false
	@FocusState private var _isSearchTextFeildFocused: Bool
	
	public init(viewModel: VM) {
		self.viewModel = viewModel
	}
	
	public var body: some View {
		
		VStack(spacing: 0) {
			
			ScrollView {
				
				LazyVStack(spacing: 20, pinnedViews: [.sectionHeaders]) {
					
					TipView(_surchargeStatusTip, action: { _ in
						// Show surcharge status tip view
					})
					.padding([.top], 10)
					.padding([.leading, .trailing], 20)
					
					Section {
						
						FavouritePlacesView()
							.padding([.leading, .trailing], 20)
						
					} header:  {
						Text("Favourite Places")
							.font(.title3)
							.blurBackground()
					}
					
					if viewModel.isLoading {
						
						Spacer()
						
						CircleProgress()
						
						Spacer()
						
					} else {
						
						if viewModel.noResults {
							
							NoResultView(searchedText: viewModel.searchedText)
								.padding(.top, 40)
								.padding([.leading, .trailing], 20)
							
						} else {
							
							if !viewModel.mainModel.places.isEmpty {
								
								Section {
									PlacesView(mainModel: $viewModel.mainModel) {
										Task {
											await viewModel.next()
										}
									}
									
								} header: {
									Text("Search for \"\(viewModel.searchedText)\"")
										.font(.title3)
										.blurBackground()
								}
								
							} else {
								
								WelcomeView()
									.padding(.top, 40)
									.padding([.leading, .trailing], 20)
								
							}
						}
					}
				}
			}
			.scrollDismissesKeyboard(.interactively)
			
			HStack(spacing: 10) {
				
				Button {
					
					if viewModel.isDeniedToUseUserLocation {
						_showLocationDeniedAlert.toggle()
					} else {
						
						withAnimation {
							viewModel.toggleUserLocation()
						}
						
						_useLocationTip.invalidate(reason: .actionPerformed)
						
					}
					
				} label: {
					
					if viewModel.isDeniedToUseUserLocation {
						Image(systemName: "location.slash")
							.foregroundStyle(R.color.blue600.color)
					} else {
						Image(systemName: viewModel.isUserLocationOn ? "location.fill" : "location")
							.foregroundStyle(R.color.blue600.color)
					}
					
				}
				.buttonStyle(.plain)
				.contentTransition(.symbolEffect(.replace))
				.alert(
					"Use Location is Denied",
					isPresented: $_showLocationDeniedAlert
				) {
					
					Button {
						
						UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
						
					} label: {
						Text("Go to Settings")
					}
					
					Button(role: .cancel) {
						_showLocationDeniedAlert.toggle()
					} label: {
						Text("Close")
					}
					
				} message: {
					Text("Allow to use your location")
				}
				.popoverTip(_useLocationTip, arrowEdge: .leading) { action in
					withAnimation {
						viewModel.toggleUserLocation()
					}
					_useLocationTip.invalidate(reason: .actionPerformed)
				}
				
				TextField("Search your destination", text: $viewModel.searchText)
					.textFieldStyle(.roundedBorder)
					.font(.body)
					.disabled(viewModel.isLoading)
					.onSubmit {
						Task {
							await viewModel.search()
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
						await viewModel.search()
					}
				} label: {
					Text("Search")
						.font(.body)
						.disabled(!viewModel.canSearch)
				}
				
			}
			.padding([.top], 10)
			.padding([.leading, .trailing], 30)
			.padding([.bottom], 10)
			
		}
		.navigationTitle("Surcharges💸")
		.navigationBarTitleDisplayMode(.automatic)
		.task {
			try? Tips.configure()
		}
	}
}
