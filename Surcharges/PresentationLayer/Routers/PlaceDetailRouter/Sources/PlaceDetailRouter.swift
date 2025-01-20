//
//  PlaceDetailRouter.swift
//  PlaceDetailRouter
//
//  Created by Bonsung Koo on 20/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import RouterProtocols

public final class PlaceDetailRouter: PlaceDetailRouterProtocol {
	
	public typealias Destination = PlaceDetailRouterDestination
	
	@Published public var activeSheet: Destination?
	
	public init() { }

	public func present(_ destination: Destination) {
		activeSheet = destination
	}
}
