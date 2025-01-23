//
//  RecognisedModel.swift
//  Models
//
//  Created by Bonsung Koo on 21/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct RecognisedModel: Equatable, Sendable {
	
	public enum RecognisedResult: Equatable, Sendable {
		case recognised
		case placeNotMatched
		case extractedPartially
		case mayNotReceiptOrPurchaseTerminal
		case notExtractable
		case unknown
	}
	
	public let result: RecognisedResult
	
	public init(result: RecognisedResult) {
		self.result = result
	}
}
