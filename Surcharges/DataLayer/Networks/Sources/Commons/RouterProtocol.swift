//
//  RouterProtocol.swift
//  Networks
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import EndpointProtocol

import Alamofire

public protocol RouterProtocol where Endpoint: EndpointProtocol {
	associatedtype Endpoint
	var endpoint: Endpoint { get }
  var path: String { get }
  var url: URL { get }
  var method: HTTPMethod { get }
  var parameterEncoding: ParameterEncoding { get }
  var headers: HTTPHeaders { get }
}

public extension RouterProtocol {
	
	var endpoint: Endpoint {
		Endpoint()
	}
	
  var url: URL {
		let urlString = endpoint.baseURL + path
		
    guard let percentedUrlString = urlString
      .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
      fatalError("Can not add percent encoding")
    }
    
    do {
      return try percentedUrlString.asURL()
    } catch {
      fatalError(error.localizedDescription)
    }
  }
  
  var headers: HTTPHeaders {
    var httpHeaders: HTTPHeaders = [:]
    httpHeaders.add(.accept("application/json"))
		httpHeaders.add(.authorization("\(endpoint.authorisationScheme) \(endpoint.authorisationToken)"))
    return httpHeaders
  }
  
}
