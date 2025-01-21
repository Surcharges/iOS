//
//  RecogniseReceiptImageProtocol.swift
//  UseCaseProtocols
//
//  Created by Bonsung Koo on 21/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

import Entities

public protocol RecogniseReceiptImageProtocol: UseCaseProtocol
where RequestValue == RecogniseReceiptImageRequest,
			ResponseValue == RecogniseReceiptImageResponse,
			ERROR == RecogniseReceiptImageError {
	
}
