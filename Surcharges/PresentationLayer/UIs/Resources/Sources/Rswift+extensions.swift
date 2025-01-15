//
//  Rswift+extensions.swift
//  Resources
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import RswiftResources

public extension RswiftResources.ImageResource {
  var image: Image {
    Image(name, bundle: bundle)
  }
}

public extension RswiftResources.ColorResource {
  var color: Color {
    Color(name, bundle: bundle)
  }
}
