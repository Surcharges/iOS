//
//  MainFactory.swift
//  Factories
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import FactoryProtocols

import ViewModels

public struct MainFactory: MainFactoryProtocol {
  
  public static func resolve() -> MainViewModel {
    return MainViewModel()
  }
}
