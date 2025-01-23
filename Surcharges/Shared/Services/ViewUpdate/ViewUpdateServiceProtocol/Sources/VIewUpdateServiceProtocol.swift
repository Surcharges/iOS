//
//  VIewUpdateServiceProtocol.swift
//  ViewUpdateServiceProtocol
//
//  Created by Bonsung Koo on 23/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation
import Combine

import Models

@MainActor
public protocol ViewUpdateServiceProtocol: ObservableObject, Sendable {
	var notified: PassthroughSubject<ViewUpdateType, Never> { get }
	func update(_ item: ViewUpdateType) async
}
