//
//  ReportSurchargeViewModelProtocol.swift
//  ViewModelProtocols
//
//  Created by Bonsung Koo on 20/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI
import PhotosUI
import UIKit

import Models

public protocol ReportSurchargeViewModelProtocol: ViewModelProtocol {
	var placeName: String { get }
	var selectedPhoto: PhotosPickerItem? { get set }
	var selectedImage: Data? { get set }
	
	var totalAmount: String { get set }
	var surchargeAmount: String { get set }
	
	var isRecognising: Bool { get }
	var isRecognised: Bool { get }
	var isReporting: Bool { get }
	var isReported: Bool { get }
	
	var isReportButtonDisabled: Bool { get }
	
	var recognisedModel: RecognisedModel? { get }
	
	func howeverProceedAnyway()
	func report() async
}
