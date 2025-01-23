//
//  ConvertPlaceEntityToModel.swift
//  ViewModels
//
//  Created by Bonsung Koo on 23/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import Entities
import Models

struct ConvertPlaceEntityToModel {
	static func convert(place: Entities.Place, surcharge: Entities.Surcharge) -> Models.Place {
		
		var location: Models.Location? {
			guard let latitude = place.location?.latitude, let longitude = place.location?.longitude else {
				return nil
			}
			return .init(latitude: latitude, longitude: longitude)
		}
		
		var surchargeStatus: Models.SurchargeStatus {
			switch surcharge.status {
			case .unknown: return .unknown
			case .reported: return .reported
			case .confirmed: return .confirmed
			}
		}
		
		var updatedDate: Date? {
			guard let date = surcharge.updatedDate else { return nil }
			return Date(timeIntervalSince1970: TimeInterval(date.seconds))
		}

		return .init(
			id: place.id,
			name: place.displayName.text,
			address: place.addressComponents.prefix(4).map { $0.longText }.joined(separator: " "),
			location: location,
			surcharge: .init(status: surchargeStatus, rate: surcharge.rate, updatedDate: updatedDate)
		)
	}
}
