//
//  AppStatusServiceMock.swift
//  UseCasesTests
//
//  Created by Bonsung Koo on 29/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import AppStatusServiceProtocol

public final class AppStatusServiceMock: AppStatusServiceProtocol {
	public var appStatus: AppStatus?
	
	public func notifyAppStatus(_ status: AppStatus) { }
}
