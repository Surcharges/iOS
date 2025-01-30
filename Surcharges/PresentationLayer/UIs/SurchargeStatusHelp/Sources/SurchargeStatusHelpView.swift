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
			
			Text(R.string.localizable.tipSurchargeStatusTitle())
				.font(.largeTitle)
				.fontWeight(.bold)
				.padding([.top], 20)
			
			ScrollView(showsIndicators: false) {
				
				VStack(spacing: 30) {
					
					Text("*\(R.string.localizable.surchargeStatusHelpDisclaimer())")
						.multilineTextAlignment(.leading)
						.fontWeight(.bold)
						.padding([.top], 20)
					
					Text(R.string.localizable.surchargeStatusHelpDiscription())
						.frame(maxWidth: .infinity, alignment: .leading)
						.multilineTextAlignment(.leading)
						.font(.headline)
						
					HStack {
						Text(R.string.localizable.surchargeStatusUnknown())
							.font(.title3)
							.surchargeStatusUnknown()
						
						Text(R.string.localizable.surchargeStatusReported())
							.font(.title3)
							.surchargeStatusReported()
						
						Text(R.string.localizable.surchargeStatusConfirmed())
							.font(.title3)
							.surchargeStatusConfirmed()
					}
					
					VStack(spacing: 15) {
						Text(R.string.localizable.surchargeStatusUnknown())
							.foregroundStyle(R.color.red800.color)
						
						VStack(spacing: 0) {
							
							Text(R.string.localizable.surchargeStatusHelpUnknown1())
								.frame(maxWidth: .infinity, alignment: .leading)
							
							Text(
								_styledText(
									string: R.string.localizable.surchargeStatusHelpUnknown2(),
									target: R.string.localizable.surchargeStatusHelpUnknown2Emphasise(),
									color: R.color.red800.color
								)
							)
							.frame(maxWidth: .infinity, alignment: .leading)
							
						}
					}
					
					VStack(spacing: 15) {
						Text(R.string.localizable.surchargeStatusReported())
							.foregroundStyle(R.color.blue800.color)
						
						VStack(spacing: 0) {
							
							Text(R.string.localizable.surchargeStatusHelpReported1())
								.frame(maxWidth: .infinity, alignment: .leading)
							
							Text(
								_styledText(
									string: R.string.localizable.surchargeStatusHelpReported2(),
									target: R.string.localizable.surchargeStatusHelpReported2Emphasise(),
									color: R.color.blue800.color
								)
							)
							.frame(maxWidth: .infinity, alignment: .leading)
							
						}
					}
					
					VStack(spacing: 15) {
						Text(R.string.localizable.surchargeStatusConfirmed())
							.foregroundStyle(R.color.green800.color)
						
						VStack(spacing: 0) {
							
							Text(R.string.localizable.surchargeStatusHelpConfirmed1())
								.frame(maxWidth: .infinity, alignment: .leading)
							
							Text(_styledText(string: R.string.localizable.surchargeStatusHelpConfirmed2(), target: R.string.localizable.surchargeStatusHelpConfirmed2Emphasise(), color: R.color.green800.color))
								.frame(maxWidth: .infinity, alignment: .leading)
							
						}
					}
					
					Button {
						_dismiss()
					} label: {
						Text("\(R.string.localizable.gotIt())!👌")
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
