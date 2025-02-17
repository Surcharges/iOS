//
//  AppDelegate.swift
//  Surcharges
//
//  Created by Bonsung Koo on 23/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import UIKit

import FirebaseCore
import GoogleMobileAds

final class AppDelegate: NSObject, UIApplicationDelegate {
	func application(
		_ application: UIApplication, didFinishLaunchingWithOptions
		launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
	) -> Bool {
		FirebaseApp.configure()
		GADMobileAds.sharedInstance().start(completionHandler: nil)
		return true
	}
}
