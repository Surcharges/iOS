//
//  MainFactory.swift
//  Factories
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import FactoryProtocols

import Repositories
import UseCases
import ViewModels

public struct MainFactory: MainFactoryProtocol {
	
	public typealias ViewModel = MainViewModel<GetPlacesUsecase<PlaceRepository>>
  
	public static func resolve() -> ViewModel {
		return MainViewModel(getPlaces: GetPlacesUsecase(placeRepository: PlaceRepository()))
  }
}
