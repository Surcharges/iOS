//
//  SurchargeStatusHelpView.swift
//  SurchargeStatusHelpDemo
//
//  Created by Bonsung Koo on 23/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import CommonUI
import UIExtensions
import Resources

public struct SurchargeStatusHelpView: View {
	
	@Environment(\.dismiss) private var _dismiss
	
	@State private var _contentHeight: CGFloat = 0
	@State private var _presentationIndents: Set<PresentationDetent> = []
	@State private var _selectedPresentationIndents: PresentationDetent = .height(0)
	
	public init() { }
	
	public var body: some View {
		
		VStack(spacing: 0) {
			
			Text("Surcharge Status")
				.font(.largeTitle)
				.fontWeight(.bold)
				.padding([.top], 20)
			
			ScrollView(showsIndicators: false) {
				
				VStack(spacing: 30) {
					
					Text("*Disclaimer: Although we are trying to provide the most accurate information, there may be some inaccuracies. Please use the information as a reference.")
						.multilineTextAlignment(.leading)
						.fontWeight(.bold)
						.padding([.top], 20)
					
					Text("There are three types of surcharge status:")
						.frame(maxWidth: .infinity, alignment: .leading)
						.multilineTextAlignment(.leading)
						.font(.headline)
						
					HStack {
						Text("Unknown")
							.font(.title3)
							.surchargeStatusUnknown()
						
						Text("Reported")
							.font(.title3)
							.surchargeStatusReported()
						
						Text("Confirmed")
							.font(.title3)
							.surchargeStatusConfirmed()
					}
					
					VStack(spacing: 15) {
						Text("Unknown")
							.foregroundStyle(R.color.red800.color)
						
						VStack(spacing: 0) {
							
							Text("Means the surcharge status is not yet known. We're please to receive your report.")
								.frame(maxWidth: .infinity, alignment: .leading)
							
							Text(_styledText(string: "Remeber, Red colour is unknown about surcharge.", target: "Red", color: R.color.red800.color))
								.frame(maxWidth: .infinity, alignment: .leading)
							
						}
					}
					
					VStack(spacing: 15) {
						Text("Reported")
							.foregroundStyle(R.color.blue800.color)
						
						VStack(spacing: 0) {
							
							Text("Means the surcharge status is reported from someone who has passion to help others.\nHowever, it's not yet confirmed which means it may not be accurate.")
								.frame(maxWidth: .infinity, alignment: .leading)
							
							Text(_styledText(string: "Remeber, Blue colour is reported but not confirmed.", target: "Blue", color: R.color.blue800.color))
								.frame(maxWidth: .infinity, alignment: .leading)
							
						}
					}
					
					VStack(spacing: 15) {
						Text("Confimed")
							.foregroundStyle(R.color.green800.color)
						
						VStack(spacing: 0) {
							
							Text("Means the surcharge status is confirmed by us. It's highly likely to be accurate.\nBut still, it may be accurate. Please check the updated date in place detail.")
								.frame(maxWidth: .infinity, alignment: .leading)
							
							Text(_styledText(string: "Remeber, Green colour is confirmed for surcharge information.", target: "Green", color: R.color.green800.color))
								.frame(maxWidth: .infinity, alignment: .leading)
							
						}
					}
					
					Button {
						_dismiss()
					} label: {
						Text("Got it!👌")
							.font(.title3)
					}
					.buttonStyle(.borderedProminent)
				}
			}
			.padding(.horizontal, 20)
		}
		.readSize { size in
			_contentHeight = size.height
		}
		.presentationDetents([.large])
		
	}
	
	private func _styledText(string: String, target: String, color: Color) -> AttributedString {
		var attributedString = AttributedString(string)
		if let range = attributedString.range(of: target) {
			attributedString[range].foregroundColor = color
			attributedString[range].font = .system(.body, design: .default).weight(.bold)
		}
		return attributedString
	}
}

#Preview {
	SurchargeStatusHelpView()
}
