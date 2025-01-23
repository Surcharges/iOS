//
//  ViewUpdateType.swift
//  ViewUpdateServiceProtocol
//
//  Created by Bonsung Koo on 23/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import Models

public enum ViewUpdateType: Identifiable, Equatable, Sendable {
	case surchargeInformationUpdated(Place)
	
	public var id: String {
		switch self {
		case .surchargeInformationUpdated(let place):
			return place.id
		}
	}
}
