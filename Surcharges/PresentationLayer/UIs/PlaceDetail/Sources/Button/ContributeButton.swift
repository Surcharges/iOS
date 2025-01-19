//
//  ContributeButton.swift
//  PlaceDetail
//
//  Created by Bonsung Koo on 20/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import Models

struct ContributeButton: View {
	
	private let _surcharge: Surcharge
	
	init(surcharge: Surcharge) {
		_surcharge = surcharge
	}
	
	var body: some View {
		
		Button {
			
			switch _surcharge.status {
			case .notDetermined:
				break
			case .unknown:
				break
			case .reported:
				break
			case .confirmed:
				break
			}
			
		} label: {
			
			Text(buttonText())
				.padding([.leading, .trailing], 10)
				.padding([.top, .bottom], 5)
			
		}
		
	}
	
	private func buttonText() -> String {
		
		switch _surcharge.status {
		case .notDetermined: return ""
		case .unknown: return "We're welcome to your contribution🙏🏻"
		case .reported: return ""
		case .confirmed: return "Something wrong?🤔"
		}
	}
}
