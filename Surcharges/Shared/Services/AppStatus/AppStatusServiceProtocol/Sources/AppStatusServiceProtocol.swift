//
//  AppStatusServiceProtocol.swift
//  AppStatusServiceProtocol
//
//  Created by Bonsung Koo on 22/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation
import Combine

@MainActor
public protocol AppStatusServiceProtocol: ObservableObject, Sendable {
	var appStatus: AppStatus? { get set }
	
	func notifyAppStatus(_ status: AppStatus)
}
