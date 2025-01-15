//
//  API.swift
//  Networks
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import Alamofire

public struct API {
  static let _manager: Session = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 20
    configuration.timeoutIntervalForResource = 20
    configuration.httpCookieStorage = HTTPCookieStorage.shared
    configuration.allowsCellularAccess = true
    configuration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
    
    let manager = Session(configuration: configuration)
    return manager
  }()
}
