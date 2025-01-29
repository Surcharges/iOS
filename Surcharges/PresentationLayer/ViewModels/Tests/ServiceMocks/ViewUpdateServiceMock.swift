//
//  ViewUpdateServiceMock.swift
//  ViewModelsTests
//
//  Created by Bonsung Koo on 29/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation
import Combine

import ViewUpdateServiceProtocol

final class ViewUpdateServiceMock: ViewUpdateServiceProtocol {
	var notified = PassthroughSubject<ViewUpdateType, Never>()
	
	func update(_ item: ViewUpdateType) async { }
}
