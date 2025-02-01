//
//  blurHeader.swift
//  CommonUI
//
//  Created by Bonsung Koo on 16/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import Resources

public extension View {
	func blurBackground() -> some View {
		self
			.background(.ultraThinMaterial, in: Rectangle())
	}
	
	func blurRoundedBackground(cornerRadius: CGFloat) -> some View {
		self
			.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius))
	}
}
