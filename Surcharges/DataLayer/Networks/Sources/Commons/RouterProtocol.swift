//
//  RouterProtocol.swift
//  Networks
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import Alamofire

import os

public protocol RouterProtocol {
  var path: String { get }
  var url: URL { get }
  var method: HTTPMethod { get }
  var parameterEncoding: ParameterEncoding { get }
  var headers: HTTPHeaders { get }
}

public extension RouterProtocol {
  var url: URL {
    let urlString = Endpoint.url + path

    guard let percentedUrlString = urlString
      .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
      fatalError("Can not add percent encoding")
    }
    
    os_log(.info, log: .networks, "%@", "\(method.rawValue): \(path)")

    do {
      return try percentedUrlString.asURL()
    } catch {
      fatalError(error.localizedDescription)
    }
  }
  
  var headers: HTTPHeaders {
    var httpHeaders: HTTPHeaders = [:]
    httpHeaders.add(.accept("application/json"))
    return httpHeaders
  }
  
}

extension OSLog {
  static var networks: OSLog {
    let subsystem = Bundle.main.bundleIdentifier ?? ""
    return OSLog(subsystem: subsystem, category: "Networks")
  }
}
