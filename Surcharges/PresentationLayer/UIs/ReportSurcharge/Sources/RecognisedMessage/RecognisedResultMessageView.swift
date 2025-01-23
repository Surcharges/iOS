//
//  RecognisedResultMessageView.swift
//  ReportSurcharge
//
//  Created by Bonsung Koo on 21/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import Resources
import Models

struct RecognisedResultMessageView: View {
	
	private let _recognisedModel: RecognisedModel
	private let _howeverProceedAnyway: () -> Void
	
	init(recognisedModel: RecognisedModel, howeverProceedAnyway: @escaping () -> Void) {
		_recognisedModel = recognisedModel
		_howeverProceedAnyway = howeverProceedAnyway
	}
	
	var body: some View {
		VStack(spacing: 0) {
			
			switch _recognisedModel.result {
			case .recognised:
				
				Text("Recognised🎉, Just in case please check the amounts, if it may not accurate.")
					.messageStyle(color: R.color.green800.color)

			case .placeNotMatched:
				
				VStack(spacing: 5) {
					Text("Place name is not matched.")
						.messageStyle(color: R.color.red800.color)
					
					Button {
						_howeverProceedAnyway()
					} label: {
						Text("Do you think the recognition sucks?\nTap here to proceed anyway.")
							.font(.subheadline)
					}
				}
				
			case .extractedPartially:
				
				Text("It is recognised partially. Please input the rest manually.")
					.messageStyle(color: R.color.red800.color)
				
			case .mayNotReceiptOrPurchaseTerminal:
				
				VStack(spacing: 5) {
					Text("It may not be a receipt or purchase terminal.")
						.messageStyle(color: R.color.red800.color)
					
					Button {
						_howeverProceedAnyway()
					} label: {
						Text("Do you think the recognition sucks?\nTap here to proceed anyway.")
							.font(.subheadline)
					}
				}
				
			case .notExtractable:
				
				Text("It is not extractable. Place input manually.")
					.messageStyle(color: R.color.red800.color)
				
			case .unknown:
				
				Text("Opps! Something went wrong. Please try again.")
					.messageStyle(color: R.color.red800.color)
			}
		}
	}
}

private extension View {
	func messageStyle(color: Color) -> some View {
		self
			.frame(maxWidth: .infinity, alignment: .leading)
			.multilineTextAlignment(.leading)
			.font(.subheadline)
			.foregroundStyle(color)
	}
}
