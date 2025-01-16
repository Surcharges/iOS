//
//  SurchargeStatusTip.swift
//  Main
//
//  Created by Bonsung Koo on 16/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI
import TipKit

import CommonUI

struct SurchargeStatusTip: Tip {
	var title: Text {
		Text("Surcharge Status")
	}
	
	var message: Text? {
		Text("Get to know different surcharge status")
	}
	
	var image: Image? {
		Image(systemName: "info.circle")
	}
	
	var actions: [Action] {
		[
			Action(
				id: "learn-more",
				title: "Learn More"
			)
		]
	}
	
}


//struct SurchargeStatusTipStyle: TipViewStyle {
//	func makeBody(configuration: TipViewStyleConfiguration) -> some View {
//		let tip = configuration.tip as! SurchargeStatusTip
//		
//		let action = configuration.actions.first!
//		
//		Image("dollarsign.circle")
//			.frame(height: 150)
//			.onTapGesture { action.handler() }
//			.overlay {
//				VStack {
//					configuration.title.font(.title)
//					HStack {
//						configuration.message.font(.subheadline)
//						Image(systemName: "chevron.circle")
//					}
//				}
//			}
//	}
//}
//
//
