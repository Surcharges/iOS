//
//  MainView.swift
//  Main
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import ViewModelProtocols

public struct MainView<VM: MainViewModelProtocol>: View {
  
  @ObservedObject var viewModel: VM
  
  public init(viewModel: VM) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    VStack(spacing: 10) {
      Text("\(viewModel.title)")
    }
  }
}
