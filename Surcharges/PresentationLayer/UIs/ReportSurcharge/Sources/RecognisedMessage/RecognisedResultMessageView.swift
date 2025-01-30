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
				
				Text(R.string.localizable.recognitionSuccess())
					.messageStyle(color: R.color.green800.color)

			case .placeNotMatched:
				
				VStack(spacing: 5) {
					Text(R.string.localizable.recognitionNameNotMatched())
						.messageStyle(color: R.color.red800.color)
					
					Button {
						_howeverProceedAnyway()
					} label: {
						Text(R.string.localizable.reportProceedAnyway())
							.font(.subheadline)
					}
				}
				
			case .extractedPartially:
				
				Text(R.string.localizable.recognitionExtractedPartially())
					.messageStyle(color: R.color.red800.color)
				
			case .mayNotReceiptOrPurchaseTerminal:
				
				VStack(spacing: 5) {
					Text(R.string.localizable.notReceipt())
						.messageStyle(color: R.color.red800.color)
					
					Button {
						_howeverProceedAnyway()
					} label: {
						Text(R.string.localizable.reportProceedAnyway())
							.font(.subheadline)
					}
				}
				
			case .notExtractable:
				
				Text(R.string.localizable.recognitionFailed())
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
