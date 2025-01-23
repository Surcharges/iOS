//
//  AmountExtractor.swift
//  UseCases
//
//  Created by Bonsung Koo on 21/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation
import Vision
import NaturalLanguage

public struct AmountExtractor {
	static public func invoke(image: Data) throws -> [Double] {
		let tagger = NLTagger(tagSchemes: [.nameTypeOrLexicalClass])
		
		var extractedText: [String] = []
		
		let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
			
			if let error = error {
				print("Error: \(error)")
			} else {
				
				guard let observations = request.results as? [VNRecognizedTextObservation] else {
					return
				}
				
				let ocrResults = observations
					.compactMap { $0.topCandidates(1).first?.string }
					.filter { $0.contains("$") }
					.joined(separator: "\n")
				
				tagger.string = ocrResults
				tagger.enumerateTags(
					in: ocrResults.startIndex ..< ocrResults.endIndex,
					unit: .sentence,
					scheme: .nameTypeOrLexicalClass,
					options: [.omitPunctuation, .omitWhitespace]
				) { tag, range in
					extractedText.append(String(ocrResults[range]))
					return true
				}
			}
		}
		
		recognizeTextRequest.recognitionLevel = .accurate
		
		do {
			
			try VNImageRequestHandler(data: image, options: [:]).perform([recognizeTextRequest])
			
			let pattern = try Regex(#"^\$([1-9]\d{0,2}(,\d{3})*|0)(\.\d{1,2})?$"#)
			
			let amounts = extractedText
				.map { $0.replacingOccurrences(of: " ", with: "") }
				.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
				.compactMap {
					let components = $0.split(separator: "$", maxSplits: 1, omittingEmptySubsequences: false)
					return components.count > 1 ? String("$" + components[1]) : nil
				}
				.filter { $0.contains(pattern) }
				.map { $0.replacingOccurrences(of: "$", with: "") }
				.removeDuplicates()
				.compactMap { Double($0) }
			
			return amounts
			
		} catch(let error) {
			throw error
		}
	}
}

private extension Sequence where Element: Hashable {
	func removeDuplicates() -> [Element] {
		return Array(Set(self))
	}
}
