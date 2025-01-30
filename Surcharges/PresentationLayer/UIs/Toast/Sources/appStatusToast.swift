//
//  appStatusToast.swift
//  Toast
//
//  Created by Bonsung Koo on 27/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import Resources
import AppStatusServiceProtocol

import ToastUI

extension View {
	public func appStatusToast(
		appStatus: Binding<AppStatus?>,
		dismissAfter: Double? = nil,
		onDismiss: (() -> Void)? = nil
	) -> some View {
		self
			.toast(item: appStatus, dismissAfter: dismissAfter, onDismiss: onDismiss) { status in
				switch status {
				case .toast(let type):
					switch type {
					case .unauthorised:
						ToastView("\(R.string.localizable.toastUnauthorised())😁")
							.toastViewStyle(.failure)
					case .outOfRegion(let availableRegions):
						ToastView("\(R.string.localizable.toastOutOfRegion()) \(availableRegions.map { _countryName(from: $0) }.joined(separator: ", "))")
							.toastViewStyle(.information)
					case .noInternet:
						ToastView("🛜\(R.string.localizable.toastNoInternet())")
							.toastViewStyle(.warning)
					case .needToUpdate:
						ToastView("🔥\(R.string.localizable.toastNewVersion())")
							.toastViewStyle(.information)
					case .unknown(let message):
						ToastView("\(R.string.localizable.toastUnknown())\n\(message)")
							.toastViewStyle(.failure)
					}
				}
			}
			.toastDimmedBackground(false)
	}
	
	private func _countryName(from countryCode: String) -> String {
		if let name = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: countryCode) {
			// Country name was found
			
			let flag = _flag(countryCode: countryCode)
			
			return "\(name)\(flag)"
		} else {
			// Country name cannot be found
			return countryCode
		}
	}
	
	public func _flag(countryCode:String) -> String {
		let baseFlagScalar: UInt32 = 127397
		var flagString = ""
		for scalarValue in countryCode.uppercased().unicodeScalars {
			guard let scalar = UnicodeScalar(baseFlagScalar + scalarValue.value) else {
				continue
			}
			flagString.unicodeScalars.append(scalar)
		}
		return flagString
	}
}
