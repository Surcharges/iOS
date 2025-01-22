//
//  ReportSurcharge.swift
//  UseCases
//
//  Created by Bonsung Koo on 22/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import Entities
import UseCaseProtocols
import RepositoryProtocols

public struct ReportSurcharge<Repository: SurchargeRepositoryProtocol>: ReportSurchargeProtocol {
	
	public typealias RequestValue = ReportSurchargeRequest
	public typealias ERROR = ReportSurchargeError
	
	private let _surchargeRepository: Repository
	
	public init(surchargeRepository: Repository) {
		_surchargeRepository = surchargeRepository
	}
	
	public func invoke(requestValue: RequestValue) async throws(ERROR) {
		do {
			try await _surchargeRepository.reportSurcharge(
				request: .init(
					plcaeId: requestValue.placeId,
					totalAmount: requestValue.totalAmount,
					surchargeAmount: requestValue.surchargeAmount,
					receiptImageData: requestValue.receiptImageData
				)
			)
		} catch(let error) {
			switch error {
			case .notAuthorized:
				throw .notAuthorized
			case .parameterError, .unknown:
				throw .unknown
			}
		}
		
	}
}
	
