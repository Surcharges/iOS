//
//  SurchargesApp.swift
//  Surcharges
//
//  Created by Bonsung Koo on 23/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import DevelopmentEndpoint
import DevelopmentAdsService

@main
struct SurchargesApp: App {
	
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	
	init() { }
	
	var body: some Scene {
		WindowGroup {
			
			SurchargeAppView<DevelopmentEndpoint, DevelopmentAdsService>()
			
		}
	}
}
