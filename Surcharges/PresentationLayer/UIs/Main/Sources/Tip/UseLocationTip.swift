//
//  UseLocationTip.swift
//  Main
//
//  Created by Bonsung Koo on 17/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI
import TipKit

struct UseLocationTip: Tip {
	var title: Text {
		Text("Use Your Location")
	}
	
	var message: Text? {
		Text("Search for nearby places.")
	}
	
	var image: Image? {
		Image(systemName: "location.magnifyingglass")
	}
	
	var actions: [Action] {
		[
			Action(
				id: "use-location-now",
				title: "Use Location Now"
			)
		]
	}
	
	@Parameter
	static var tryToSearch: Bool = false
	
	var rules: [Rule] {
		#Rule(Self.$tryToSearch) {
			$0 == true
		}
	}
	
}
