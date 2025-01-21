//
//  PlaceValidator.swift
//  UseCases
//
//  Created by Bonsung Koo on 21/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import Foundation
import Vision
import NaturalLanguage

public struct PlaceValidator {
	
	static public func matched(placeName: String, image: Data) throws -> Bool {
		
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
					.joined(separator: "\n")
				
				let placeNameComponent = placeName
					.components(separatedBy: " ")
					.map { $0.lowercased() }
				
				tagger.string = ocrResults
				tagger.enumerateTags(
					in: ocrResults.startIndex ..< ocrResults.endIndex,
					unit: .word,
					scheme: .nameTypeOrLexicalClass,
					options: [.omitPunctuation, .omitWhitespace]
				) { tag, range in
					let word = String(ocrResults[range]).trimmingCharacters(in: .whitespacesAndNewlines)
					
					if placeNameComponent.contains(word.lowercased()) {
						extractedText.append(String(ocrResults[range]))
					}
					return true
					
				}
			}
		}
		
		recognizeTextRequest.recognitionLevel = .accurate
		
		do {
			
			try VNImageRequestHandler(data: image, options: [:]).perform([recognizeTextRequest])
			
			return !extractedText.isEmpty
			
		} catch(let error) {
			throw error
		}
	}
	
}
