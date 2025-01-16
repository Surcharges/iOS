//
//  surchargeStatus.swift
//  CommonUI
//
//  Created by Bonsung Koo on 16/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import Resources

public extension View {
	func surchargeStatusUnknown() -> some View {
		self._style(foreground: R.color.red800.color, background: R.color.red300.color)
	}
	
	func surchargeStatusReported() -> some View {
		self._style(foreground: R.color.blue800.color, background: R.color.blue300.color)
	}
	
	func surchargeStatusConfirmed() -> some View {
		self._style(foreground: R.color.green800.color, background: R.color.green300.color)
	}
	
	private func _style(foreground: Color, background: Color) -> some View {
		self
			.foregroundStyle(foreground)
			.padding(7)
			.background(
				background
					.cornerRadius(5)
			)
	}
}
