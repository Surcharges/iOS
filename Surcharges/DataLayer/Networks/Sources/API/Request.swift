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
  
  private static func _buildRequest(
    _ router: RouterProtocol,
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
  
  static func request<Res: Decodable>(
    dto: Res.Type,
    router: RouterProtocol,
    parameters: Parameters = [:]
  ) async -> Result<Res?, NetworkError> {

    let request = await _buildRequest(router, parameters).response
    
    return response(dto, request)
  }
}
