//
//  SurchargeView.swift
//  PlaceDetailDemo
//
//  Created by Bonsung Koo on 19/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import Models
import Resources

import Shimmer

struct SurchargeView: View {
	
	private let _placeName: String
	private let _placeAddress: String
	private let _surcharge: Surcharge
	private let _isLoading: Bool
	
	init(
		placeName: String,
		placeAddress: String,
		surcharge: Surcharge,
		isLoading: Bool
	) {
		_placeName = placeName
		_placeAddress = placeAddress
		_surcharge = surcharge
		_isLoading = isLoading
	}
	
	var body: some View {
		VStack(spacing: 10) {
			
			VStack(spacing: 10) {
				
				Text(_placeName)
					.font(.headline)
					.frame(maxWidth: .infinity, alignment: .leading)
					.multilineTextAlignment(.leading)
					.shimmering(active: _isLoading)
					.redacted(reason: _isLoading ? .placeholder : [])
				
				Text(_placeAddress)
					.font(.subheadline)
					.frame(maxWidth: .infinity, alignment: .leading)
					.multilineTextAlignment(.leading)
					.shimmering(active: _isLoading)
					.redacted(reason: _isLoading ? .placeholder : [])
			}
			
			VStack(spacing: 10) {
				
				switch _surcharge.status {
					
				case .notDetermined:
					
					Text("X%")
						.font(.largeTitle)
						.redacted(reason: .placeholder)
						.shimmering(active: _isLoading)
						.cornerRadius(5)
					
					Text(verbatim: "NotDetermined")
						.font(.headline)
						.padding(7)
						.background(
							R.color.gray300.color
								.cornerRadius(5)
						)
						.redacted(reason: .placeholder)
						.shimmering(active: _isLoading)
						.cornerRadius(5)
					
				case .unknown:
					
					Text("\(R.string.localizable.surchargeStatusUnknownMessage())😞")
						.font(.headline)
					
					Text(verbatim: R.string.localizable.surchargeStatusUnknown())
						.font(.headline)
						.surchargeStatusUnknown()
						
				case .reported:
					
					Text(verbatim: _rateText(rate: _surcharge.rate))
						.font(.largeTitle)
					
					Text(verbatim: R.string.localizable.surchargeStatusReported())
						.font(.headline)
						.surchargeStatusReported()
					
				case .confirmed:
					
					Text(verbatim: _rateText(rate: _surcharge.rate))
						.font(.largeTitle)
					
					Text(verbatim: R.string.localizable.surchargeStatusConfirmed())
						.font(.headline)
						.surchargeStatusConfirmed()
					
				}
				
				if let updatedDate = _surcharge.updatedDate {
					Text(R.string.localizable.updatedAt(updatedDate.formatted(date: .numeric, time: .omitted)))
						.font(.footnote)
				}
				
			}
			.padding(.top, 30)
		}
		.padding(20)
		
	}
	
	private func _rateText(rate: Double?) -> String {
		if let rate = rate {
			return rate == 0 ? "\(R.string.localizable.zeroRates)🎉" : "\(rate)%"
		} else {
			return R.string.localizable.surchargeStatusUnknown()
		}
	}
}


#Preview {
	VStack {
		SurchargeView(
			placeName: "Starbucks Lambton Quey",
			placeAddress: "223 Lambton Quey Wellington Central Wellington 6011 New Zealand",
			surcharge: .init(status: .unknown, rate: nil, updatedDate: nil),
			isLoading: true
		)
		SurchargeView(
			placeName: "Starbucks Lambton Quey",
			placeAddress: "223 Lambton Quey Wellington Central Wellington 6011 New Zealand",
			surcharge: .init(status: .reported, rate: 1, updatedDate: Date()),
			isLoading: false
		)
		SurchargeView(
			placeName: "Starbucks Lambton Quey",
			placeAddress: "223 Lambton Quey Wellington Central Wellington 6011 New Zealand",
			surcharge: .init(status: .confirmed, rate: 2.5, updatedDate: Date()),
			isLoading: false
		)
	}
	
}
