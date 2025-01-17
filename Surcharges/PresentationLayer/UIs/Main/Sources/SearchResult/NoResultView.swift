//
//  NoResultView.swift
//  Main
//
//  Created by Bonsung Koo on 16/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

import Resources

struct NoResultView: View {
	
	private let _searchedText: String
	
	init(searchedText: String) {
		_searchedText = searchedText
	}
	
	var body: some View {
		VStack(spacing: 20) {
			
			if #available(iOS 18.0, *) {
				Image(systemName: "exclamationmark.magnifyingglass")
					.font(.largeTitle)
					.symbolEffect(.wiggle.clockwise, options: .speed(0.5))
			} else {
				Image(systemName: "exclamationmark.magnifyingglass")
					.font(.largeTitle)
			}
				
			Text("Oops!\nNo results found for \"\(_searchedText)\"")
				.font(.subheadline)
				.multilineTextAlignment(.center)
				
		}
	}
}


#Preview {
	NoResultView(searchedText: "someting to search")
}
