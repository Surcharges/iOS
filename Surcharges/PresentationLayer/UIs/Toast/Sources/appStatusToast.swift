//
//  appStatusToast.swift
//  Toast
//
//  Created by Bonsung Koo on 27/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

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
