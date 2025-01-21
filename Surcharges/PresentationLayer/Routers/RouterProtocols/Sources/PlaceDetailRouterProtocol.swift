//
//  PlaceDetailRouterProtocol.swift
//  RouterProtocols
//
//  Created by Bonsung Koo on 20/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

public enum PlaceDetailRouterDestination: Equatable, Identifiable {
	case reportSurchargeInformation(placeId: String, placeName: String)
	
	public var id: String {
		switch self {
		case .reportSurchargeInformation(let id, _):
			return id
		}
	}
}

public protocol PlaceDetailRouterProtocol: RouterProtocol where Destination == PlaceDetailRouterDestination {
	var activeSheet: Destination? { get }
	func present(_ destination: Destination)
}
