//
//  SurchargeStatusHelpApp.swift
//  SurchargeStatusHelpDemo
//
//  Created by Bonsung Koo on 23/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import SurchargeStatusHelp

@main
struct PlaceDetailApp: App {
	
	@State private var isSurchargeStatusHelpViewPresented = false
	
	var body: some Scene {
		WindowGroup {
			VStack {
				
			}
			.sheet(isPresented: .constant(true)) {
				SurchargeStatusHelpView()
			}
		}
	}
}
