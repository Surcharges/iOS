//
//  FavouritePlacesView.swift
//  Main
//
//  Created by Bonsung Koo on 16/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import Resources

struct FavouritePlacesView: View {
	
	var body: some View {
		VStack(spacing: 0) {
				
			HStack(spacing: 10) {
				if #available(iOS 18.0, macOS 14.0, *) {
					Image(systemName: "star.fill")
						.foregroundStyle(R.color.yellow300.color)
						.symbolEffect(.bounce.up, options: .speed(0.6).repeat(.periodic))
						.imageScale(.large)
				} else {
					Image(systemName: "star.fill")
						.foregroundStyle(R.color.yellow300.color)
						.symbolEffect(.variableColor.iterative, options: .speed(0.6))
						.imageScale(.large)
				}
				
				Text("⏳You will see your favourite places here soon.\n👀Glence at your favourite places.")
					.font(.headline)
			}
			.padding(10)
			
		}
		.frame(maxWidth: .infinity)
		.background(
			RoundedRectangle(cornerRadius: 20)
				.stroke(lineWidth: 1)
		)
		
	}
}

#Preview {
	VStack {
		FavouritePlacesView()
	}
}
