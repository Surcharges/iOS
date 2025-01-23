//
//  RecogniseReceiptImage.swift
//  UseCases
//
//  Created by Bonsung Koo on 21/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import UseCaseProtocols
import Entities

public struct RecogniseReceiptImage: RecogniseReceiptImageProtocol {
	public typealias RequestValue = RecogniseReceiptImageRequest
	public typealias ResponseValue = RecogniseReceiptImageResponse
	public typealias ERROR = RecogniseReceiptImageError
	
	public init() { }
	
	public func invoke(requestValue: RequestValue) async -> Result<ResponseValue, ERROR> {
		do {
			
			let placeMatched = try PlaceValidator.matched(placeName: requestValue.placeName, image: requestValue.image)
			
			if !placeMatched {
				return .failure(.placeNotMatched)
			}
			
			let amounts = try AmountExtractor.invoke(image: requestValue.image)
			
			if amounts.isEmpty {
				return .failure(.mayNotReceiptOrPurchaseTerminal)
			} else if amounts.count == 1 {
				
				return .failure(.extractedPartially(totalAmount: amounts.first, surchargeAmount: nil))
			} else {
				
				if let largestAmount = amounts.max(by: { $0 < $1 }),
					 let smallestAmount = amounts.min(by: { $0 < $1 }) {
				
					return .success(.init(totalAmount: largestAmount, surchargeAmount: smallestAmount))
				} else {
					
					return .failure(.notExtractable)
				}
				
			}
		} catch(let error) {
			return .failure(.unknown)
		}
	}
}
