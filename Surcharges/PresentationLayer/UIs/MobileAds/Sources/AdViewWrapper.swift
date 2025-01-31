//
//  AdViewWrapper.swift
//  MobileAds
//
//  Created by Bonsung Koo on 31/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import UIKit
import SwiftUI

import GoogleMobileAds

struct AdViewWrapper: UIViewRepresentable {
	private let _adSize: GADAdSize
	private let _unitId: String
	
	init(_ adSize: GADAdSize, unitId: String) {
		_adSize = adSize
		_unitId = unitId
	}
	
	func makeUIView(context: Context) -> UIView {
		let view = UIView()
		view.addSubview(context.coordinator.bannerView)
		return view
	}
	
	func updateUIView(_ uiView: UIView, context: Context) {
		context.coordinator.bannerView.adSize = _adSize
	}
	
	func makeCoordinator() -> BannerCoordinator {
		return BannerCoordinator(self, unitId: _unitId)
	}
	
	@MainActor
	class BannerCoordinator: NSObject, GADBannerViewDelegate {
		
		private let _unitId: String
		
		private(set) lazy var bannerView: GADBannerView = {
			let banner = GADBannerView(adSize: _parent._adSize)
			banner.adUnitID = _unitId
			banner.load(GADRequest())
			banner.delegate = self
			return banner
		}()
		
		private let _parent: AdViewWrapper
		
		init(_ parent: AdViewWrapper, unitId: String) {
			_parent = parent
			_unitId = unitId
		}
	}
}
