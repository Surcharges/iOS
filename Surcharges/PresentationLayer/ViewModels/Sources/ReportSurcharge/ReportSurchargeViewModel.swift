//
//  ReportSurchargeViewModel.swift
//  ViewModels
//
//  Created by Bonsung Koo on 20/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI
import PhotosUI
import Combine

import Models
import Entities
import UseCaseProtocols
import ViewModelProtocols
import ViewUpdateServiceProtocol

public final class ReportSurchargeViewModel<
	RecogniseReceiptImage: RecogniseReceiptImageProtocol,
	ReportSurcharge: ReportSurchargeProtocol,
	ViewUpdateService: ViewUpdateServiceProtocol
>: BaseViewModel, ReportSurchargeViewModelProtocol {
	
	@Published public var placeName: String
	@Published public var selectedPhoto: PhotosPickerItem?
	@Published public var selectedImage: Data?
	
	@Published public var totalAmount: String = ""
	@Published public var surchargeAmount: String = ""
	
	@Published public var isRecognising: Bool = false
	@Published public var isRecognised: Bool = false
	@Published public var isReporting: Bool = false
	@Published public var isReported: Bool = false
	@Published public var recognisedModel: RecognisedModel?
	
	public var isReportButtonDisabled: Bool {
		
		if totalAmount == "" || surchargeAmount == "" {
			return true
		}
		
		return isRecognising || isReporting
	}
	
	@Published private var _imageData: Data?
	
	private var _cancellables: Set<AnyCancellable> = []
	
	private let _placeId: String
	private let _recogniseReceiptImage: RecogniseReceiptImage
	private let _reportSurcharge: ReportSurcharge
	
	private let _viewUpdateService: ViewUpdateService
	
	public init(
		placeId: String,
		placeName: String,
		recogniseReceiptImage: RecogniseReceiptImage,
		reportSurcharge: ReportSurcharge,
		viewUpdateService: ViewUpdateService
	) {
		_placeId = placeId
		self.placeName = placeName
		_recogniseReceiptImage = recogniseReceiptImage
		_reportSurcharge = reportSurcharge
		_viewUpdateService = viewUpdateService
		
		super.init()
		
		_bindTakingImageData()
		_bindRecogniseImage()
		
	}
	
	public func howeverProceedAnyway() {
		isRecognised = true
	}
	
	public func report() async {
		
		isReporting = true
		
		guard let totalAmount = Double(totalAmount),
					let surchargeAmount = Double(surchargeAmount),
					let imageData = _imageData else {
			isReporting = false
			return
		}
		
		do {
			
			let result = try await _reportSurcharge.invoke(
				requestValue: .init(
					placeId: _placeId,
					totalAmount: totalAmount,
					surchargeAmount: surchargeAmount,
					receiptImageData: imageData
				)
			)
			
			isReporting = false
			isReported = true
			
			await _viewUpdateService.update(
				.surchargeInformationUpdated(
					ConvertPlaceEntityToModel.convert(place: result.place, surcharge: result.surcharge)
				)
			)
			
		} catch {
			
			isReporting = false
			
		}
		
	}
	
	private func _bindTakingImageData() {
		
		$selectedImage
			.compactMap { $0 }
			.sink { [weak self] selectedImage in
				self?.selectedPhoto = nil
				self?._imageData = selectedImage
			}
			.store(in: &_cancellables)
		
		$selectedPhoto
			.compactMap { $0 }
			.sink { [weak self] selectedPhoto in
				self?.isRecognising = true
				self?.selectedImage = nil
				
				Task {
					do {
						self?._imageData = try await selectedPhoto.loadTransferable(type: Data.self)
					} catch {
						self?.isRecognising = false
					}
					
				}
				
			}
			.store(in: &_cancellables)
		
	}
	
	private func _bindRecogniseImage() {
		$_imageData
			.compactMap { $0 }
			.sink { [weak self] imageData in
				
				guard let self = self else { return }
				
				if !isRecognising {
					isRecognising = true
				}
				
				Task {
					
					do {
						
						let recognisingResult = try await self._recogniseReceiptImage.invoke(
							requestValue: .init(placeName: self.placeName, image: imageData)
						)
						
						self.totalAmount = "\(recognisingResult.totalAmount)"
						self.surchargeAmount = "\(recognisingResult.surchargeAmount)"
						
						isRecognised = true
						
						self.recognisedModel = .init(result: .recognised)
						
					} catch (let error as RecogniseReceiptImageError) {
						
						self.totalAmount = ""
						self.surchargeAmount = ""
						
						switch error {
						case .placeNotMatched:
							
							isRecognised = false
							
							self.recognisedModel = .init(result: .placeNotMatched)

						case .notExtractable:
							
							isRecognised = true
							
							self.recognisedModel = .init(result: .notExtractable)
							
						case .mayNotReceiptOrPurchaseTerminal:
							
							isRecognised = false
							
							self.recognisedModel = .init(result: .mayNotReceiptOrPurchaseTerminal)
							
						case .extractedPartially(let totalAmount, let surchargeAmount):
							
							if let totalAmount = totalAmount {
								self.totalAmount = "\(totalAmount)"
							}
							if let surchargeAmount = surchargeAmount {
								self.surchargeAmount = "\(surchargeAmount)"
							}
							
							isRecognised = true
							
							self.recognisedModel = .init(result: .extractedPartially)
							
						}
					}
					
					isRecognising = false
					
				}
				
			}
			.store(in: &_cancellables)
	}
}
