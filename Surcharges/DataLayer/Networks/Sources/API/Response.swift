//
//  Response.swift
//  Networks
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import DTOs

import Alamofire

extension API {
	
	static func response<Res: BasicServerResponse>(_ dto: Res.Type, _ request: DataResponse<Data, AFError>) throws(NetworkError) -> Res {
		
		guard let response = request.response else { throw .systemError }
		
#if DEBUG
//		if let response = request.response,
//			 let data = request.data {
//			responseViewForDebug(data: (response, data))
//		}
#endif
		
		switch response.status {
		case .ok, .created:
			
			do {
				guard let data = request.data else {
					throw NetworkError.failureResponseDecoding(reason: "No data")
				}
				
				let decodedDto = try JSONDecoder().decode(dto.self, from: data)
				return decodedDto
				
			} catch(let error) {
				throw .failureResponseDecoding(reason: error.localizedDescription)
			}
		
		default:
			try _errorHandler(request: request)
		}
		
		fatalError("There must be a return statement.")
	}
	
	static func response(request: DataResponse<Data, AFError>) throws(NetworkError) {
		
		guard let _ = request.response else { throw .systemError }
		
#if DEBUG
//		if let response = request.response,
//			 let data = request.data {
//			responseViewForDebug(data: (response, data))
//		}
#endif
		
		try _errorHandler(request: request)
	}
	
	static private func _errorHandler(request: DataResponse<Data, AFError>) throws(NetworkError) {
		
		guard let response = request.response else { throw .systemError }
		
		switch response.status {
		case .ok, .created, .noContent:
			return
		case .badRequest:
			throw .badRequest
		case .forbidden:
			throw .forbidden(reason: .region(availableRegions: ["nz"]))
		case .unauthorised:
			throw .unauthorised
		case .notFound:
			throw .notFound
		case .methodNotAllowed:
			throw .methodNotAllowed
		case .gone:
			throw .deprecatedAPI
		case .serverError:
			throw .serverError
		case .gatewayTimeout:
			throw .gatewayTimeout
		case .undefinedError:
			throw .unknown
		}
	}
}

extension API {
	static func responseViewForDebug(data: (HTTPURLResponse, Data)) {
		if let res = try? JSONSerialization.jsonObject(with: data.1, options: .fragmentsAllowed) {
			print(res)
		} else {
			print(data.0)
			print("can not parsing response")
		}
	}
}
