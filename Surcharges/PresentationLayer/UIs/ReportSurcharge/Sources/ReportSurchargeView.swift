//
//  ReportSurchargeView.swift
//  ReportSurcharge
//
//  Created by Bonsung Koo on 20/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI
import PhotosUI

import Resources
import CommonUI
import UIExtensions

import ViewModelProtocols
import RouterProtocols

public struct ReportSurchargeView<VM: ReportSurchargeViewModelProtocol, Router: ReportSurchargeRouterProtocol>: View {
	
	@Environment(\.dismiss) private var dismiss
	
	@StateObject private var _viewModel: VM
	@StateObject private var _router: Router
	
	@State private var _isShowingPhotosicker = false
	@State private var _isShowingImageicker = false
	
	@State private var _contentHeight: CGFloat = 0
	@State private var _presentationIndents: Set<PresentationDetent> = []
	@State private var _selectedPresentationIndents: PresentationDetent = .height(0)
	
	public init(viewModel: VM, router: Router) {
		__viewModel = StateObject(wrappedValue: viewModel)
		__router = StateObject(wrappedValue: router)
	}
	
	public var body: some View {
		
		ScrollView(showsIndicators: false) {
			VStack(spacing: 20) {
				VStack(spacing: 10) {
					Text("You are going to report surcharge information for")
						.fixedSize(horizontal: false, vertical: true)
						.font(.title3)
						.multilineTextAlignment(.center)
					
					Text(_viewModel.placeName)
						.fixedSize(horizontal: false, vertical: true)
						.font(.largeTitle)
						.fontWeight(.bold)
						.multilineTextAlignment(.center)
				}
				.padding(.top, 20)
				
				VStack(spacing: 0) {
					
					Text("Please take or select a photo of the receipt or terminal screen for recognising surcharge information.")
						.fixedSize(horizontal: false, vertical: true)
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.subheadline)
						.multilineTextAlignment(.leading)
					
					Text("Please Note. When you report this information, the photo will be uploaded to the server to verify the information.")
						.fixedSize(horizontal: false, vertical: true)
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.subheadline)
						.fontWeight(.bold)
						.multilineTextAlignment(.leading)
				}
				
				Menu {
					Button {
						_isShowingPhotosicker.toggle()
					} label: {
						HStack {
							Image(systemName: "photo")
							Text("Select a photo")
						}
					}
					Button {
						_isShowingImageicker.toggle()
					} label: {
						HStack {
							Image(systemName: "camera")
							Text("Take a photo")
						}
					}
				} label: {
					
					if _viewModel.isRecognising {
						HStack {
							Text("Recognising...")
							ProgressView()
						}
					} else {
						Text("📸 or 🏞️")
					}
					
				}
				.buttonStyle(.borderedProminent)
				.disabled(_viewModel.isRecognising || _viewModel.isReporting)
				
				if let recognisedModel = _viewModel.recognisedModel {
					
					RecognisedResultMessageView(recognisedModel: recognisedModel, howeverProceedAnyway: {
						_viewModel.howeverProceedAnyway()
					})
					
				}
				
				if _viewModel.isRecognised {
					
					VStack(spacing: 10) {
						
						VStack(spacing: 5) {
							
							Text("Total Amount")
								.font(.caption)
								.frame(maxWidth: .infinity, alignment: .leading)
							
							TextField("Enter total amount", text: $_viewModel.totalAmount)
								.keyboardType(.decimalPad)
								.textFieldStyle(.roundedBorder)
								.disabled(_viewModel.isRecognising || _viewModel.isReporting)
							
						}
						
						VStack(spacing: 5) {
							
							Text("Surcharge Amount")
								.font(.caption)
								.frame(maxWidth: .infinity, alignment: .leading)
							
							TextField("Enter amount of surcharge", text: $_viewModel.surchargeAmount)
								.keyboardType(.decimalPad)
								.textFieldStyle(.roundedBorder)
								.disabled(_viewModel.isRecognising || _viewModel.isReporting)
							
						}
						
					}
					.padding([.leading, .trailing], 20)
					
					Button {
						Task {
							await _viewModel.report()
						}
					} label: {
						
						if _viewModel.isReporting {
							HStack {
								Text("Reporting...")
								ProgressView()
							}
						} else {
							Text("📝Report")
						}
						
					}
					.buttonStyle(.borderedProminent)
					.disabled(_viewModel.isReportButtonDisabled)
					
				}
				
			}
			.padding(20)
			.readSize { size in
				_contentHeight = size.height
			}
			.onChange(of: _contentHeight, { _, newValue in
				_presentationIndents.insert(.height(newValue))
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
					_selectedPresentationIndents = .height(newValue)
				}
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
					_presentationIndents = [.height(newValue)]
				}
				
			})
			
		}
		.presentationDetents(_presentationIndents, selection: $_selectedPresentationIndents)
		.scrollDismissesKeyboard(.interactively)
		.interactiveDismissDisabled(_viewModel.isReporting)
		.scrollDisabled(_viewModel.isRecognised ? false : true)
		.photosPicker(
			isPresented: $_isShowingPhotosicker,
			selection: $_viewModel.selectedPhoto,
			matching: .images,
			preferredItemEncoding: .compatible
		)
		.imagePicker(isPresented: $_isShowingImageicker, selectedImage: $_viewModel.selectedImage)
		.overlay(_viewModel.isReported ? ThanksView(placeName: _viewModel.placeName) : nil)
		.onChange(of: _viewModel.isReported) { _, newValue in
			
			_presentationIndents.insert(.large)
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
				_selectedPresentationIndents = .large
			}
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
				_presentationIndents = [.large]
			}
		}
	}
}
