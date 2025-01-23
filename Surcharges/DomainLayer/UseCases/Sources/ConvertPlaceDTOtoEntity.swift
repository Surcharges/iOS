//
//  ConvertPlaceDTOtoEntity.swift
//  UseCases
//
//  Created by Bonsung Koo on 23/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import DTOs
import Entities

struct ConvertDTOtoEntity {
	static func place(dto: DTOs.Place) -> Entities.Place {
		var location: Entities.Location? {
			if let location = dto.location {
				return .init(latitude: location.latitude, longitude: location.longitude)
			} else {
				return nil
			}
		}
		
		return .init(
			id: dto.id,
			 displayName: .init(text: dto.displayName.text, languageCode: dto.displayName.languageCode),
			 addressComponents: dto.addressComponents.map {
				 .init(longText: $0.longText, shortText: $0.shortText, types: $0.types)
			 },
			 location: location
		 )
	}
	
	static func surcharge(dto: DTOs.Place) -> Entities.Surcharge {
		var surchargeStatus: Entities.SurchargeStatus {
			switch dto.surchargeStatus {
			case .UNKNOWN: return .unknown
			case .REPORTED: return .reported
			case .CONFIRMED: return .confirmed
			default: return .unknown
			}
		}
		
		var updatedDate: Entities.TimeStamp? {
			if let updatedDate = dto.reportedDate {
				return .init(nanoseconds: updatedDate._nanoseconds, seconds: updatedDate._seconds)
			} else {
				return nil
			}
		}
		
		return .init(status: surchargeStatus, rate: dto.surchargeRate, updatedDate: updatedDate)
	}
}
