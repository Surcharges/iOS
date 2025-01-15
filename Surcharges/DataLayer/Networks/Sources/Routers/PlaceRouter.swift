//
//  PlaceRouter.swift
//  Networks
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import Alamofire

enum PlaceRouter: RouterProtocol {
  case places(searchText: String, nextPageToken: String?)
  case place(id: String)
}

extension PlaceRouter {
  var path: String {
    switch self {
    case .places(let searchText, let nextPageToken):
      return "/places?searchText=\(searchText)&nextPageToken=\(nextPageToken ?? "")"
    case .place(let id):
      return "/places?id=\(id)"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .places, .place:
      return .get
    }
  }
  
  var parameterEncoding: ParameterEncoding {
    switch self {
    case .places, .place:
      return URLEncoding.default
    }
  }
}
