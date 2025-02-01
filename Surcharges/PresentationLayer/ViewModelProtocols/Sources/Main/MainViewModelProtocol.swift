//
//  MainViewModelProtocol.swift
//  ViewModelProtocols
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import Models

public protocol MainViewModelProtocol: ViewModelProtocol {
	var mainModel: MainModel { get set }
	var searchText: String { get set }
	var searchedText: String { get }
	var showWelcome: Bool { get }
	var isLoading: Bool { get }
	var noResults: Bool { get }
	var canSearch: Bool { get }
	var isDeniedToUseUserLocation: Bool { get }
	var isUserLocationOn: Bool { get }
  
	func search() async
	func next() async
	func toggleUserLocation()
}
