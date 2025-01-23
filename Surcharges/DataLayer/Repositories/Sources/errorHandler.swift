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

extension RepositoryProtocol {
	
	public func errorHandlerExceptNotFound(appStatusService: AppStatusService, error: NetworkError) async {
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
		case .notFound:
			return
		default:
			await appStatusService.notifyAppStatus(.toast(.unknown(message: error.localizedDescription)))
		}
	}
}
