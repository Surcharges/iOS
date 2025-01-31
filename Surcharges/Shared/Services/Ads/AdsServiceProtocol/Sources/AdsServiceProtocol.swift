//
//  AdsServiceProtocol.swift
//  AdsServiceProtocol
//
//  Created by Bonsung Koo on 31/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public protocol AdsServiceProtocol: ObservableObject {
	init()
	var isShowingAds: Bool { get set }
	var fixedBannerUnitId: String { get }
	var listBannerUnitId: String { get }
}
