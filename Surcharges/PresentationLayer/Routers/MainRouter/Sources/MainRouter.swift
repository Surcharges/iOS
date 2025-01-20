//
//  MainRouter.swift
//  MainRouter
//
//  Created by Bonsung Koo on 20/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import RouterProtocols

public final class MainRouter: MainRouterProtocol {
	
	public typealias Destination = MainRouterDestination
	
	@Published public var activeSheet: Destination?
	
	public init() { }

	public func present(_ destination: Destination) {
		activeSheet = destination
	}
}
