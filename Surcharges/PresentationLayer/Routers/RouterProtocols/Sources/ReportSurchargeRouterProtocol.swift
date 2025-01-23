//
//  ReportSurchargeRouterProtocol.swift
//  RouterProtocols
//
//  Created by Bonsung Koo on 20/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

public enum ReportSurchargeRouterDestination: Equatable, Identifiable {
	public var id: String {
		return "Empty Enum"
	}
}

public protocol ReportSurchargeRouterProtocol: RouterProtocol where Destination == ReportSurchargeRouterDestination {
	
}
