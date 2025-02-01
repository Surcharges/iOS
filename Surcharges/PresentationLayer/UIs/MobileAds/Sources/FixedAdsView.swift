//
//  FixedAdsView.swift
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

public struct FixedAdsView: View {
	
	enum AdShowingMoment {
		case hide
		case thanks
		case show
	}
	
	@State private var _adSize: GADAdSize = .init()
	@State private var _adShowingMoment: AdShowingMoment = .hide
	@Binding private var _isAdShowing: Bool
	
	private let _unitId: String
	
	public init(isAdShowing: Binding<Bool>, unitId: String) {
		__isAdShowing = isAdShowing
		_unitId = unitId
		
		if _isAdShowing {
			__adShowingMoment = .init(initialValue: .show)
		}
	}
	
	public var body: some View {
		
		VStack {
			
			switch _adShowingMoment {
			
			case .hide:
				
				VStack(spacing: 10) {
					
					LottieView {
						return .dotLottieFile(
							try await .named(R.file.adsLottie.filename, bundle: R.file.adsLottie.bundle)
						)
					}
					.playbackMode(.playing(.fromProgress(0, toProgress: 1, loopMode: .loop)))
					.frame(maxWidth: 200, maxHeight: 200)
					
					Text(R.string.localizable.exposingAdsSuggestion())
						.font(.headline)
						.multilineTextAlignment(.center)
					
					Button {
						
						_isAdShowing = true
						
						withAnimation {
							_adShowingMoment = .thanks
						}
						
						DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
							withAnimation {
								_adShowingMoment = .show
							}
						}
						
					} label: {
						Text(R.string.localizable.exposingAdsAcceptButtonTitle())
					}
					.padding(.top, 20)
					
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.padding()
			
			case .thanks:
				
				VStack {
					Text("\(R.string.localizable.exposingAdsThanks())🎉")
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
			
			case .show:
				
				AdViewWrapper(_adSize, unitId: _unitId)
				
			}
		}
		.frame(minHeight: _adSize.size.width, maxHeight: _adSize.size.width)
		.cornerRadius(20)
		.readSize { size in
			_adSize = GADAdSizeFromCGSize(.init(width: size.width, height: size.width))
		}
	}
}
