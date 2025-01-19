//
//  MapLoadingView.swift
//  PlaceDetailDemo
//
//  Created by Bonsung Koo on 19/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import Resources

struct MapLoadingView: View {
	
	@Environment(\.colorScheme) var colorScheme
	
	var body: some View {
		if #available(iOS 18.0, macOS 14.0,*) {
			Image(systemName: "map")
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.font(.largeTitle)
				.symbolEffect(.breathe.byLayer.plain, options: .speed(2))
				.background(colorScheme == .dark ? R.color.black.color : R.color.white.color)
		} else {
			Image(systemName: "map")
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.font(.largeTitle)
				.symbolEffect(.appear, options: .speed(2))
				.background(colorScheme == .dark ? R.color.black.color : R.color.white.color)
		}
	}
}
