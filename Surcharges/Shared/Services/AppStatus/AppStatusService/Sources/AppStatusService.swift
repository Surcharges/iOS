//
//  AppStatusService.swift
//  AppStatusService
//
//  Created by Bonsung Koo on 22/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import AppStatusServiceProtocol

public final class AppStatusService: AppStatusServiceProtocol {

	@Published public var appStatus: AppStatus?
	
	public init() { }
	
	public func notifyAppStatus(_ status: AppStatus) {
		appStatus = status
	}
}
