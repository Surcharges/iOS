//
//  MainViewModelProtocol.swift
//  ViewModelProtocols
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public protocol MainViewModelProtocol: ObservableObject {
  var title: String { get set }
  
  func changeTitle(_ title: String)
}
