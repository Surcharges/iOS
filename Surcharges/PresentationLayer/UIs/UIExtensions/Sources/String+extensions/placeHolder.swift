//
//  placeholder.swift
//  UIExtensions
//
//  Created by Bonsung Koo on 19/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

public extension String {
	static func placeholder(length: Int) -> String {
		return String(repeating: " ", count: length)
	}
}
