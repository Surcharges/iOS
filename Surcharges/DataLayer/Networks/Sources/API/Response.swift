//
//  Response.swift
//  Networks
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import Alamofire

extension API {
	
	static func response<Res: Decodable>(
		_ dto: Res.Type,
		_ request: DataResponse<Data, AFError>
	) -> Result<Res?, NetworkError> {
		
		guard let response = request.response else { return .failure(.systemConnection) }
		
#if DEBUG
//		if let response = request.response,
//			 let data = request.data {
//			responseViewForDebug(data: (response, data))
//		}
#endif
		
		switch response.status {
		case .ok:
			do {
				
				guard let data = request.data else {
					return .failure(.responseIsEmpty)
				}
				
				let decodedDto = try JSONDecoder().decode(dto.self, from: data)
				return .success(decodedDto)
				
			} catch {
				return .failure(.failureResponseDecoding(reason: error.localizedDescription))
			}
			
		case .noContent:
			
			return .success(nil)
			
		case .badRequest:
			return .failure(.badRequest)
		case .forbidden:
			return .failure(.forbidden)
		case .notAuthorized:
			return .failure(.tokenInvalid)
		case .methodNotAllowed:
			return .failure(.methodNotAllowed)
		case .gone:
			return .failure(.deprecatedAPI)
		case .serverError:
			return .failure(.serverError)
		case .gatewayTimeout:
			return .failure(.gatewayTimeout)
		case .undefinedError:
			return .failure(.unknown)
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
