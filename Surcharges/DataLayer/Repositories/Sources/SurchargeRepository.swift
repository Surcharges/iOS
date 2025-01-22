//
//  SurchargeRepository.swift
//  Repositories
//
//  Created by Bonsung Koo on 22/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import DTOs

import Networks
import RepositoryProtocols

public struct SurchargeRepository: SurchargeRepositoryProtocol {
	
	public init() { }
	
	public func reportSurcharge(request: ReportSurchargeRequest) async throws(ResponseError) {
		do {
			
			try await API.request(
				router: SurchargeRouter.reportSurcharge,
				parameters: [
					"placeId": request.plcaeId,
					"totalAmount": request.totalAmount,
					"surchargeAmount": request.surchargeAmount,
					"image": request.receiptImageData.base64EncodedString()
				]
			)
			
		} catch (let error) {
			switch error {
			case .badRequest:
				throw .parameterError
			case .tokenInvalid:
				throw .notAuthorized
			default:
				throw .unknown
			}
		}
	}
}
