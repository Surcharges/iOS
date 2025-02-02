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
					
					Section {
						
						if _viewModel.isLoading {
							
							CircleProgress()
							
						} else {
							
							if _viewModel.noResults {
								
								NoResultView(searchedText: _viewModel.searchedText)
									.padding(.top, 40)
									.padding([.leading, .trailing], 20)
								
							} else {
								
								if !_viewModel.mainModel.places.isEmpty {
									
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
						
					} header: {
						
						if !_viewModel.showWelcome {
							
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
							
						} else {
							
							Rectangle()
								.foregroundStyle(R.color.clear.color)
								.frame(height: 20)
							
						}
						
					}
					
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
				}
			}
			.scrollDismissesKeyboard(.interactively)
			
			SearchView(viewModel: __viewModel)
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
