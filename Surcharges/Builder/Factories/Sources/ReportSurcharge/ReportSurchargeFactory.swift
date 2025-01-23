//
//  ReportSurchargeFactory.swift
//  Factories
//
//  Created by Bonsung Koo on 20/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import FactoryProtocols

import Repositories
import UseCases
import ViewModels
import AppStatusService
import ViewUpdateService

public struct ReportSurchargeFactory: ReportSurchargeFactoryProtocol {
	
	public typealias ViewModel = ReportSurchargeViewModel<
		RecogniseReceiptImage,
		ReportSurcharge<SurchargeRepository<AppStatusService>>,
		ViewUpdateService
	>
	
	private let _placeId: String
	private let _placeName: String
	
	private let _viewUpdateService: ViewUpdateService
	
	public init(placeId: String, placeName: String, viewUpdateService: ViewUpdateService) {
		_placeId = placeId
		_placeName = placeName
		_viewUpdateService = viewUpdateService
	}
	
	public func resolve(appStatusService: AppStatusService) -> ViewModel {
		return ReportSurchargeViewModel(
			placeId: _placeId,
			placeName: _placeName,
			recogniseReceiptImage: RecogniseReceiptImage(),
			reportSurcharge: ReportSurcharge(surchargeRepository: SurchargeRepository(appStatusService: appStatusService)),
			viewUpdateService: _viewUpdateService
		)
	}
	
}

