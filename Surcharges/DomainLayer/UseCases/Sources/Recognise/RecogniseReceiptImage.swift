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
	
	public func invoke(requestValue: RequestValue) async throws(ERROR) -> ResponseValue {
		
		do throws(ERROR) {
			
			let placeMatched = PlaceValidator.matched(placeName: requestValue.placeName, image: requestValue.image)
			
			if !placeMatched {
				throw .placeNotMatched
			}
			
			let amounts = AmountExtractor.invoke(image: requestValue.image)
			
			if amounts.isEmpty {
				throw .mayNotReceiptOrPurchaseTerminal
			} else if amounts.count == 1 {
				throw .extractedPartially(totalAmount: amounts.first, surchargeAmount: nil)
			} else {
				
				if let largestAmount = amounts.max(by: { $0 < $1 }),
					 let smallestAmount = amounts.min(by: { $0 < $1 }) {
				
					return .init(totalAmount: largestAmount, surchargeAmount: smallestAmount)
				} else {
					throw .notExtractable
				}
				
			}
			
		} catch (let error) {
			throw error
		}
	}
}
