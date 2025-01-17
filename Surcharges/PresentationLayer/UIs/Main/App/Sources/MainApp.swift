//
//  MainApp.swift
//  MainDemo
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI
import TipKit

import Main
import Factories

@main
struct MainApp: App {
  var body: some Scene {
    WindowGroup {
			NavigationStack {
				MainView(viewModel: MainFactory.resolve())
//					.onAppear {
//						try? Tips.resetDatastore()
//					}
			}
    }
  }
}
