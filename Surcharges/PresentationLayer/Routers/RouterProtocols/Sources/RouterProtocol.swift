//
//  RouterProtocol.swift
//  RouterProtocols
//
//  Created by Bonsung Koo on 20/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI

public protocol RouterProtocol: ObservableObject where Destination: Equatable & Identifiable {
	associatedtype Destination
}
