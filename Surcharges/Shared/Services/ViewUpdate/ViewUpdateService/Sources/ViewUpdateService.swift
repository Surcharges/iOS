//
//  ViewUpdateService.swift
//  ViewUpdateService
//
//  Created by Bonsung Koo on 23/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation
import Combine

import ViewUpdateServiceProtocol

public final class ViewUpdateService: ViewUpdateServiceProtocol {
	
	public var notified = PassthroughSubject<ViewUpdateType, Never>()
	
	public init() { }

	public func update(_ item: ViewUpdateType) async {
		switch item {
		case .surchargeInformationUpdated(let place):
			notified.send(.surchargeInformationUpdated(place))
		}
	}
}
