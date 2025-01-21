//
//  readSize.swift
//  UIExtensions
//
//  Created by Bonsung Koo on 21/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

public extension View {
	func readSize(_ perform: @escaping (CGSize) -> Void) -> some View {
		modifier(ReadSizeModifier(action: perform))
	}
}

private struct ReadSizeModifier: ViewModifier {
	let action: (CGSize) -> Void
	
	func body(content: Content) -> some View {
		content
			.onGeometryChange(for: CGSize.self) { proxy in
				return proxy.size
			} action: { newValue in
				action(newValue)
			}
	}
}
