//
//  MainRouterProtocol.swift
//  RouterProtocols
//
//  Created by Bonsung Koo on 20/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

public enum MainRouterDestination: Equatable, Identifiable {
	case placeDetail(id: String)
	case surchargeStatusHelp
	
	public var id: String {
		switch self {
		case .placeDetail(let id):
			return id
		case .surchargeStatusHelp:
			return "\(self)"
		}
	}
}

public protocol MainRouterProtocol: RouterProtocol where Destination == MainRouterDestination {
	var activeSheet: Destination? { get }
	func present(_ destination: Destination)
}
