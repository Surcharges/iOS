//
//  MainViewModel.swift
//  ViewModels
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import ViewModelProtocols

public final class MainViewModel: MainViewModelProtocol {
  
  @Published public var title: String = "Main"
  
  public init() {
    
    
  }
  
  public func changeTitle(_ title: String) {
    self.title = title
  }
}
