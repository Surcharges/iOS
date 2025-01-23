//
//  ImagePicker.swift
//  CommonUI
//
//  Created by Bonsung Koo on 21/01/2025.
//  Copyright © 2025 Surcharges. All rights reserved.
//

import SwiftUI
import UIKit

public extension View {
	func imagePicker(isPresented: Binding<Bool>, selectedImage: Binding<Data?>) -> some View {
		self.sheet(isPresented: isPresented) {
			ImagePicker(selectedImage: selectedImage)
		}
	}
}

struct ImagePicker: UIViewControllerRepresentable {
	
	@Binding var selectedImage: Data?
	@Environment(\.dismiss) var dismiss
	
	init(selectedImage: Binding<Data?>) {
		_selectedImage = selectedImage
	}
	
	func makeUIViewController(context: Context) -> some UIViewController {
		let picker = UIImagePickerController()
		picker.sourceType = .camera
		picker.delegate = context.coordinator
		return picker
	}
	
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
		
		let parent: ImagePicker
		init(_ parent: ImagePicker) {
			self.parent = parent
		}
		
		func imagePickerController(
			_ picker: UIImagePickerController,
			didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
		) {
			if let image = info[.originalImage] as? UIImage {
				parent.selectedImage = image.jpegData(compressionQuality: 0.8)
			}
			parent.dismiss()
		}
		
		func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
			parent.dismiss()
		}
	}

}

