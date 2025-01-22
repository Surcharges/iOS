//
//  errorHandler.swift
//  Repositories
//
//  Created by Bonsung Koo on 22/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import Networks
import RepositoryProtocols
//import AppStatusServiceProtocol

extension RepositoryProtocol {
	
	public func errorHandler(appStatusService: AppStatusService, error: NetworkError) async {
		switch error {
		case .tokenInvalid:
			await appStatusService.notifyAppStatus(.toast(.notAuthorized))
		case .forbidden:
			await appStatusService.notifyAppStatus(.toast(.outOfNZ))
		case .systemConnection:
			await appStatusService.notifyAppStatus(.toast(.noInternet))
		case .deprecatedAPI:
			await appStatusService.notifyAppStatus(.toast(.needToUpdate))
		case .failureResponseDecoding(let reason):
			await appStatusService.notifyAppStatus(.toast(.unknown(message: reason)))
		default:
			await appStatusService.notifyAppStatus(.toast(.unknown(message: error.localizedDescription)))
		}
	}
}
