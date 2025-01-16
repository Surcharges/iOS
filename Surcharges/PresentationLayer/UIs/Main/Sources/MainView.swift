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
	
	@State var _isUseCurrentLocation: Bool = false
	private let _surchargeStatusTip = SurchargeStatusTip()
	
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
					
					withAnimation {
						_isUseCurrentLocation.toggle()
					}
					
				} label: {
					
					Image(systemName: _isUseCurrentLocation ? "location.fill" : "location")
						.foregroundStyle(R.color.blue600.color)
					
				}
				.buttonStyle(.plain)
				.contentTransition(.symbolEffect(.replace))
				
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
