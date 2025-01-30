//
//  ThanksView.swift
//  ReportSurcharge
//
//  Created by Bonsung Koo on 22/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import Resources

import ConfettiSwiftUI

struct ThanksView: View {
	
	@Environment(\.dismiss) var dismiss
	
	@State private var _leftConfettiTrigger: Int = 0
	@State private var _rightConfettiTrigger: Int = 0
	
	private let _placeName: String
	
	init(placeName: String) {
		_placeName = placeName
	}
	
	var body: some View {
		
		VStack(spacing: 20) {
			
			VStack(spacing: 10) {
				Text(R.string.localizable.reportSuccessTitle())
					.multilineTextAlignment(.center)
					.font(.title3)
				
				Text("\(_placeName)")
					.multilineTextAlignment(.center)
					.font(.largeTitle)
					.fontWeight(.bold)
			}
			
			HStack {
				
				Button {
					_leftConfettiTrigger += 1
				} label: {
					Text("💰")
						.font(.largeTitle)
						.rotationEffect(.degrees(45))
				}
				.confettiCannon(
					trigger: $_leftConfettiTrigger,
					confettis: [
						.text("💵"), .text("💶"), .text("💷"), .text("💴")
					],
					confettiSize: 20,
					fadesOut: false,
					openingAngle: .degrees(0),
					closingAngle: .degrees(90),
					radius: 200,
					repetitions: 1
				)
				
				Spacer()
				
				Button {
					_rightConfettiTrigger += 1
				} label: {
					Text("💰")
						.font(.largeTitle)
						.rotationEffect(.degrees(315))
				}
				.confettiCannon(
					trigger: $_rightConfettiTrigger,
					confettis: [
						.text("💵"), .text("💶"), .text("💷"), .text("💴")
					],
					confettiSize: 20,
					fadesOut: false,
					openingAngle: .degrees(90),
					closingAngle: .degrees(180),
					radius: 200,
					repetitions: 1
				)
				
				
			}
			.padding([.horizontal], 20)
			
			Button {
				
				dismiss()
				
			} label: {
				Text(R.string.localizable.backToPlace())
			}
			.buttonStyle(.borderedProminent)
			
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.blurBackground()
		.transition(.opacity.animation(.default.speed(0.5)))
		.ignoresSafeArea()
		.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
				_leftConfettiTrigger += 1
				_rightConfettiTrigger += 1
			}
		}
	}
}

#Preview {
	ThanksView(placeName: "Starbucks Lambton Quay")
}
