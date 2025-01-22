//
//  AddressComponents.swift
//  DTOs
//
//  Created by Bonsung Koo on 15/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation

public struct AddressComponents: Codable, Equatable, Sendable {
	public let longText: String
	public let shortText: String
	public let types: [String]
//	public let languageCode: String
	
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		do {
			self.longText = try container.decode(String.self, forKey: .longText)
		} catch {
			do {
				self.longText = try container.decode(String.self, forKey: .shortText)
			} catch {
				self.longText = ""
			}
		}
		
		do {
			self.shortText = try container.decode(String.self, forKey: .shortText)
		} catch {
			do {
				self.shortText = try container.decode(String.self, forKey: .longText)
			} catch {
				self.shortText = ""
			}
		}
		
		self.types = try container.decode([String].self, forKey: .types)
	}
}
