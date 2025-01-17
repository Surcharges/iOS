//
//  CircleProgress.swift
//  CommonUI
//
//  Created by Bonsung Koo on 16/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import Resources

public struct CircleProgress: View {
	
	public init() {
		
	}
	
	public var body: some View {
		Image(systemName: "progress.indicator")
			.symbolEffect(
				.variableColor.iterative.dimInactiveLayers,
				options: .speed(0.8)
			)
			.foregroundStyle(R.color.blue600.color)
			.imageScale(.large)
	}
}

#Preview {
	CircleProgress()
}
