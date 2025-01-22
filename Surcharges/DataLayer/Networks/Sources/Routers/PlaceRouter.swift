//
//  PlaceRouter.swift
//  Networks
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import Alamofire

public enum PlaceRouter: RouterProtocol {
	case places(searchText: String, nextPageToken: String?, latitude: Double?, longitude: Double?)
  case place(id: String)
}

extension PlaceRouter {
	public var path: String {
    switch self {
		case .places(let searchText, let nextPageToken, let latitude, let longitude):
			if let nextPageToken = nextPageToken {
				if let latitude = latitude, let longitude = longitude {
					return "/places?searchText=\(searchText)&nextPageToken=\(nextPageToken)&latitude=\(latitude)&longitude=\(longitude)"
				} else {
					return "/places?searchText=\(searchText)&nextPageToken=\(nextPageToken)"
				}
			} else {
				if let latitude = latitude, let longitude = longitude {
					return "/places?searchText=\(searchText)&latitude=\(latitude)&longitude=\(longitude)"
				} else {
					return "/places?searchText=\(searchText)"
				}
				
			}
    case .place(let id):
      return "/place?id=\(id)"
    }
  }
  
	public var method: HTTPMethod {
    switch self {
    case .places, .place:
      return .get
    }
  }
  
	public var parameterEncoding: ParameterEncoding {
    switch self {
    case .places, .place:
      return URLEncoding.default
    }
  }
}
