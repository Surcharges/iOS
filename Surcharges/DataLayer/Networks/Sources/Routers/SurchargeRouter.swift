//
//  SurchargeRouter.swift
//  Networks
//
//  Created by Bonsung Koo on 22/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import EndpointProtocol

import Alamofire

public enum SurchargeRouter<Endpoint>: RouterProtocol where Endpoint: EndpointProtocol {
	case reportSurcharge
}

extension SurchargeRouter {
	public var path: String {
		switch self {
		case .reportSurcharge:
			return "/surcharge/v1"
		}
	}
	
	public var method: HTTPMethod {
		switch self {
		case .reportSurcharge:
			return .post
		}
	}
	
	public var parameterEncoding: ParameterEncoding {
		switch self {
		case .reportSurcharge:
			return JSONEncoding.default
		}
	}
}
