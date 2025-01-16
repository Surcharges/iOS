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
			.padding([.top, .bottom], 10)
			.padding([.leading, .trailing], 20)
			.frame(maxWidth: .infinity, alignment: .leading)
			.background(.ultraThinMaterial, in: Rectangle())
	}
	
	func blurRoundedBackground(cornerRadius: CGFloat) -> some View {
		self
			.padding([.top, .bottom], 10)
			.padding([.leading, .trailing], 20)
			.frame(maxWidth: .infinity, alignment: .leading)
			.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius))
	}
}
