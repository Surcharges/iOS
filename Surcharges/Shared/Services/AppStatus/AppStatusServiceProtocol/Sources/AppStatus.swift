//
//  AppStatus.swift
//  AppStatusServiceProtocol
//
//  Created by Bonsung Koo on 22/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public enum AppStatus: Identifiable, Equatable, Sendable {
	case toast(_ toast: Toast)
	
	public var id: String {
		switch self {
		case .toast(let toast):
			return toast.id
		}
	}
}
