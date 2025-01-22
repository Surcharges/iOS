//
//  BaseViewModel.swift
//  ViewModels
//
//  Created by Bonsung Koo on 22/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public class BaseViewModel: NSObject {
	override init() {
		super.init()
		print("Initialised: \(self.description)")
	}
	
	deinit {
		print("Deinitialised: \(self.description)")
	}
}
