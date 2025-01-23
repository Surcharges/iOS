//
//  RecogniseReceiptImageError.swift
//  Entities
//
//  Created by Bonsung Koo on 21/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public enum RecogniseReceiptImageError: UseCaseError {
	case placeNotMatched
	case extractedPartially(totalAmount: Double?, surchargeAmount: Double?)
	case mayNotReceiptOrPurchaseTerminal
	case notExtractable
	case unknown
}
