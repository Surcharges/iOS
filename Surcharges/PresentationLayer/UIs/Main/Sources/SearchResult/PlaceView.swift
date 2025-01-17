//
//  PlaceView.swift
//  Main
//
//  Created by Bonsung Koo on 16/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import CommonUI
import Resources

import Models

struct PlaceView: View {
	
	private var _place: Place
	
	init(place: Place) {
		_place = place
	}
	
	var body: some View {
		VStack(spacing: 5) {
			
			HStack(spacing: 10) {
				
				Text(_place.name)
					.font(.headline)
					.multilineTextAlignment(.leading)
				
				if let rate = _place.surcharge.rate {
					if _place.surcharge.status == .reported {
						Text(verbatim: rate == 0 ? "Zero🎉" : "\(rate)%")
							.surchargeStatusReported()
						
					} else if _place.surcharge.status == .confirmed {
						Text(verbatim: rate == 0 ? "Zero🎉" : "\(rate)%")
							.surchargeStatusConfirmed()
					}
				}
			}
			
			Text(_place.address)
				.frame(maxWidth: .infinity, alignment: .center)
				.font(.subheadline)
				.multilineTextAlignment(.center)
			
		}
		.padding([.leading, .trailing], 20)
	}
}

#Preview {
	VStack(spacing: 10) {
		PlaceView(
			place: .init(
				id: "1",
				name: "Starbucks Porirua",
				address: "11 Hartham Pl North Porirua Porirua 5022 New Zealand",
				location: nil,
				surcharge: .init(status: .unknown, rate: nil)
			)
		)
		PlaceView(
			place: .init(
				id: "2",
				name: "Starbucks Lambton Quay",
				address: "233 Lambton Quay Wellington Central Wellington 6011 New Zealand",
				location: nil,
				surcharge: .init(status: .reported, rate: 0)
			)
		)
		PlaceView(
			place: .init(
				id: "3",
				name: "Starbucks Lower Hutt",
				address: "6 Bunny St Hutt Central Lower Hutt 5010 New Zealand",
				location: nil,
				surcharge: .init(status: .confirmed, rate: 1)
			)
		)
	}
}
