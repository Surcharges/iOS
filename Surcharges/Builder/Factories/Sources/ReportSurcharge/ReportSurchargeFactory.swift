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
import Services

public struct ReportSurchargeFactory: ReportSurchargeFactoryProtocol {
	
	public typealias ViewModel = ReportSurchargeViewModel<RecogniseReceiptImage>
	
	private let _placeId: String
	private let _placeName: String
	
	public init(placeId: String, placeName: String) {
		_placeId = placeId
		_placeName = placeName
	}
	
	public func resolve() -> ViewModel {
		return ReportSurchargeViewModel(
			placeId: _placeId,
			placeName: _placeName,
			recogniseReceiptImage: RecogniseReceiptImage()
		)
	}
	
}

