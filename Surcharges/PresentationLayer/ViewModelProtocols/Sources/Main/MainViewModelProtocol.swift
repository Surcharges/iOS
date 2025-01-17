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
	var searchedText: String { get set }
	var isLoading: Bool { get set }
	var noResults: Bool { get set }
	var canSearch: Bool { get set }
	var isDeniedToUseUserLocation: Bool { get set }
	var isUserLocationOn: Bool { get set }
  
	func search() async
	func next() async
	func toggleUserLocation()
}
