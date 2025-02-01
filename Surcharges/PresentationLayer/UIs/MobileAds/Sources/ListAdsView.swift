//
//  ListAdsView.swift
//  MobileAds
//
//  Created by Bonsung Koo on 31/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import Resources
import UIExtensions

import Lottie
import GoogleMobileAds

public struct ListAdsView: View {
	
	@State private var _adSize: GADAdSize = .init()
	
	private let _unitId: String
	
	public init(unitId: String) {
		_unitId = unitId
	}
	
	public var body: some View {
		VStack {
			AdViewWrapper(_adSize, unitId: _unitId)
				.frame(height: _adSize.size.height)
		}
		.background(R.color.gray100.color)
		.readSize { size in
			_adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(size.width)
		}
	}
}
