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
import MobileAds

import ViewModelProtocols
import RouterProtocols
import AdsServiceProtocol

public struct MainView<VM: MainViewModelProtocol, Router: MainRouterProtocol, AdsService: AdsServiceProtocol>: View {
	
	@StateObject private var _viewModel: VM
	@StateObject private var _router: Router
	@StateObject private var _adsService: AdsService = AdsService()
	
	private let _surchargeStatusTip = SurchargeStatusTip()
	private let _useLocationTip = UseLocationTip()
	@State private var _showLocationDeniedAlert = false
	@FocusState private var _isSearchTextFeildFocused: Bool
	
	public init(viewModel: VM, router: Router) {
		__viewModel = StateObject(wrappedValue: viewModel)
		__router = StateObject(wrappedValue: router)
	}
	
	public var body: some View {
		
		VStack(spacing: 0) {
			
			ScrollView {
				
				LazyVStack(spacing: 20, pinnedViews: [.sectionHeaders]) {
					
					TipView(_surchargeStatusTip, action: { _ in
						_router.present(.surchargeStatusHelp)
						_surchargeStatusTip.invalidate(reason: .actionPerformed)
					})
					.padding([.top], 10)
					.padding([.leading, .trailing], 20)
					
					/*
					 // Favourite Places is currently not available.
					Section {
						
						FavouritePlacesView()
							.padding([.leading, .trailing], 20)
						
					} header:  {
						Text("Favourite Places")
							.font(.title3)
							.blurBackground()
					}
					 */
					
					if _viewModel.isLoading {
						
						Spacer()
						
						CircleProgress()
						
						Spacer()
						
					} else {
						
						if _viewModel.noResults {
							
							NoResultView(searchedText: _viewModel.searchedText)
								.padding(.top, 40)
								.padding([.leading, .trailing], 20)
							
						} else {
							
							if !_viewModel.mainModel.places.isEmpty {
								
								Section {
									PlacesView(
										mainModel: $_viewModel.mainModel,
										selectedPlace: { placeId in
											_router.present(.placeDetail(id: placeId))
										},
										loadNextPage: {
											Task {
												await _viewModel.next()
											}
										}
									)
									
								} header: {
									
									VStack(spacing: 0) {
										
										if _adsService.isShowingAds {
											ListAdsView(unitId: _adsService.listBannerUnitId)
										}
									
										Text("🔎\(R.string.localizable.searchFor(_viewModel.searchedText))")
											.frame(maxWidth: .infinity, alignment: .leading)
											.padding([.leading, .trailing], 20)
											.padding(.top, 10)
											.padding(.bottom, 10)
										
									}
									.blurBackground()

								}
								
							} else {
								
								WelcomeView()
									.padding(.top, 40)
									.padding([.leading, .trailing], 20)
								
								FixedAdsView(isAdShowing: $_adsService.isShowingAds, unitId: _adsService.fixedBannerUnitId)
									.blurRoundedBackground(cornerRadius: 20)
									.padding([.top, .bottom], 10)
									.padding([.leading, .trailing], 20)

							}
						}
					}
				}
			}
			.scrollDismissesKeyboard(.interactively)
			
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
						Task {
							await _viewModel.search()
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
