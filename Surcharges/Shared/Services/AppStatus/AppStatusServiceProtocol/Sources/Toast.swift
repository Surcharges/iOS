//
//  Toast.swift
//  AppStatusServiceProtocol
//
//  Created by Bonsung Koo on 22/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public enum Toast: Identifiable, Equatable, Sendable {
	case unauthorised
	case outOfNZ
	case noInternet
	case needToUpdate
	case unknown(message: String)
	
	public var id: String {
		return "\(self)"
	}
}
