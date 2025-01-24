//
//  Request.swift
//  Networks
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import Alamofire

public extension API {
  
  private static func _buildRequest<Router: RouterProtocol>(
    _ router: Router,
    _ parameters: Parameters
  ) async -> DataTask<Data> {
    return _manager
      .request(
        router.url,
        method: router.method,
        parameters: parameters,
        encoding: router.parameterEncoding,
        headers: router.headers
      )
      .serializingData()
  }
  
	static func request<Res: Decodable, Router: RouterProtocol>(
		dto: Res.Type,
		router: Router,
		parameters: Parameters = [:]
	) async throws(NetworkError) -> Res {

		let request = await _buildRequest(router, parameters).response
		
		return try response(dto, request)
	}
	
	static func request<Router: RouterProtocol>(router: Router, parameters: Parameters = [:]) async throws(NetworkError) {
		
		let request = await _buildRequest(router, parameters).response
		
		return try response(request: request)
	}
}
