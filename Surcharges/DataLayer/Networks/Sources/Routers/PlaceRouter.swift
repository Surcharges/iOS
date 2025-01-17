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
  case places(searchText: String, nextPageToken: String?)
  case place(id: String)
}

extension PlaceRouter {
	public var path: String {
    switch self {
    case .places(let searchText, let nextPageToken):
			if let nextPageToken = nextPageToken {
				return "/places?searchText=\(searchText)&nextPageToken=\(nextPageToken)"
			} else {
				return "/places?searchText=\(searchText)"
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
