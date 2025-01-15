//
//  MainApp.swift
//  MainDemo
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import Main
import Factories

@main
struct MainApp: App {
  var body: some Scene {
    WindowGroup {
      MainView(viewModel: MainFactory.resolve())
    }
  }
}
