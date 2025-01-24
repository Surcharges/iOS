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
import AppStatusServiceProtocol
import EndpointProtocol

public struct SurchargeRepository<
	AppStatusService: AppStatusServiceProtocol,
	Endpoint: EndpointProtocol
>: SurchargeRepositoryProtocol {
	
	private let _appStatusService: AppStatusService
	
	public init(appStatusService: AppStatusService) {
		_appStatusService = appStatusService
	}
	
	public func reportSurcharge(request: ReportSurchargeRequest) async throws(ReportSurchargeError) -> ReportSurchargeResponse {
		do {
			
			let result = try await API.request(
				dto: ReportSurchargeResponse.self,
				router: SurchargeRouter<Endpoint>.reportSurcharge,
				parameters: [
					"placeId": request.plcaeId,
					"totalAmount": request.totalAmount,
					"surchargeAmount": request.surchargeAmount,
					"image": request.receiptImageData.base64EncodedString()
				]
			)
			
			return result
			
		} catch (let error) {
			await errorHandlerExceptNotFound(appStatusService: _appStatusService, error: error)
		}
		
		throw .notFound
	}
}
