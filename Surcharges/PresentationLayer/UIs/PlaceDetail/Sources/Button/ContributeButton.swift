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
	private let _action: () -> Void
	
	init(surcharge: Surcharge, action: @escaping () -> Void) {
		_surcharge = surcharge
		_action = action
	}
	
	var body: some View {
		
		Button {
			
			switch _surcharge.status {
			case .notDetermined, .reported:
				break
			case .unknown, .confirmed:
				_action()
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
