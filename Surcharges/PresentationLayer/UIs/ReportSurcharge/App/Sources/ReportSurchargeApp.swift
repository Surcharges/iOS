//
//  ReportSurchargeApp.swift
//  ReportSurcharge
//
//  Created by Bonsung Koo on 20/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import ReportSurcharge
import Factories
import ReportSurchargeRouter
import Models
import AppStatusService
import ViewUpdateService

import ToastUI

@main
struct ReportSurchargeApp: App {
	
	@StateObject private var _reportSurchargeRouter = ReportSurchargeRouter()
	@StateObject private var _appStatusService = AppStatusService()
	@StateObject private var _viewUpdateService = ViewUpdateService()
	
	@State private var _isShowStarbucksLambtonQuey = false
	@State private var _isShowStarbucksLowerHutt = false
	@State private var _isShowChilifashion = false
	
	private let _starbucksLambtonQuey: (String, String) = ("ChIJ__-_U9SvOG0RNehxHQPATv0", "Starbucks Lambton Quay")
	private let _starbucksLowerHutt: (String, String) = ("ChIJTbxdbFaqOG0Rt5u-D2CPNiE", "Starbucks Lower Hutt")
	private let _chilifashion: (String, String) = ("ChIJj3rAgdevOG0RttXvbKz6Z4A", "CHILI fashion and Art wellington")
	
	var body: some Scene {
		WindowGroup {
			VStack(spacing: 30) {
				Button {
					_isShowStarbucksLambtonQuey.toggle()
				} label: {
					Text("Starbucks Lambton Quay")
				}
				.sheet(isPresented: $_isShowStarbucksLambtonQuey) {
					ReportSurchargeView(
						viewModel: ReportSurchargeFactory(
							placeId: _starbucksLambtonQuey.0,
							placeName: _starbucksLambtonQuey.1,
							viewUpdateService: _viewUpdateService
						).resolve(appStatusService: _appStatusService),
						router: _reportSurchargeRouter
					)
				}
				
				Button {
					_isShowStarbucksLowerHutt.toggle()
				} label: {
					Text("Starbucks Lower Hutt")
				}
				.sheet(isPresented: $_isShowStarbucksLowerHutt) {
					ReportSurchargeView(
						viewModel: ReportSurchargeFactory(
							placeId: _starbucksLowerHutt.0,
							placeName: _starbucksLowerHutt.1,
							viewUpdateService: _viewUpdateService
						).resolve(appStatusService: _appStatusService),
						router: _reportSurchargeRouter
					)
				}
				
				Button {
					_isShowChilifashion.toggle()
				} label: {
					Text("CHILI fashion and Art wellington")
				}
				.sheet(isPresented: $_isShowChilifashion) {
					ReportSurchargeView(
						viewModel: ReportSurchargeFactory(
							placeId: _chilifashion.0,
							placeName: _chilifashion.1,
							viewUpdateService: _viewUpdateService
						).resolve(appStatusService: _appStatusService),
						router: _reportSurchargeRouter
					)
				}
				
			}
			.toast(item: $_appStatusService.appStatus, dismissAfter: 5) { status in
				switch status {
				case .toast(let type):
					switch type {
					case .notAuthorized:
						ToastView("Do you want some permissions?😁")
							.toastViewStyle(.failure)
					case .outOfNZ:
						ToastView("🇳🇿Only available in New Zealand.")
							.toastViewStyle(.information)
					case .noInternet:
						ToastView("🛜Please check the Internet connection.")
							.toastViewStyle(.warning)
					case .needToUpdate:
						ToastView("🔥New version available. Please update.")
							.toastViewStyle(.information)
					case .unknown(let message):
						ToastView("Oops🫢 Something went wrong. Please try again.\n\(message)")
							.toastViewStyle(.failure)
					}
				}
			}
			.toastDimmedBackground(false)
			
		}
	}
}
