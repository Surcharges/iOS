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
	public typealias ResponseValue = ReportSurchargeResponse
	public typealias ERROR = ReportSurchargeError
	
	private let _surchargeRepository: Repository
	
	public init(surchargeRepository: Repository) {
		_surchargeRepository = surchargeRepository
	}
	
	public func invoke(requestValue: RequestValue) async throws(ERROR) -> ResponseValue {
		do {
			
			let result = try await _surchargeRepository.reportSurcharge(
				request: .init(
					plcaeId: requestValue.placeId,
					totalAmount: requestValue.totalAmount,
					surchargeAmount: requestValue.surchargeAmount,
					receiptImageData: requestValue.receiptImageData
				)
			)
			
			let place = ConvertDTOtoEntity.place(dto: result.place)
			let surcharge = ConvertDTOtoEntity.surcharge(dto: result.surcharge)
			
			return .init(place: place, surcharge: surcharge)
			
		} catch(let error) {
			switch error {
			case .notFound:
				throw .failedToReportSurcharge
			}
		}
	}
}
	
