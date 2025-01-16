//
//  apply.swift
//  UIExtensions
//
//  Created by Bonsung Koo on 16/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

public extension View {
	@ViewBuilder
	func applyIf<T: View>(_ condition: Bool, apply: (Self) -> T) -> some View {
		if condition {
			apply(self)
		} else {
			self
		}
	}
	
	@ViewBuilder
	func apply(_ apply: (Self) -> some View) -> some View {
		apply(self)
	}
}
