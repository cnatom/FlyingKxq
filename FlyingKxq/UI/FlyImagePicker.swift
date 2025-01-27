//
//  FlyImagePicker.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/27.
//

import PhotosUI
import SwiftUI

extension View {
    func flyImagePicker(isPresented: Binding<Bool>, onImagePicked: @escaping (UIImage) -> Void) -> some View {
        modifier(FlyImagePickerViewModifier(onImagePicked: onImagePicked, isPresented: isPresented))
    }
}

struct FlyImagePickerViewModifier: ViewModifier {
    let onImagePicked: (UIImage) -> Void
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                FlyImagePicker(onImagePicked: onImagePicked)
            }
    }
}

struct FlyImagePickerViewModifierPreview: View {
    @State var image: UIImage?
    @State var showImagePicker = false
    var body: some View {
        VStack {
            Button("选择图片") {
                showImagePicker.toggle()
            }
            .flyImagePicker(isPresented: $showImagePicker) { image in
                self.image = image
            }
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 500)
            }
        }
    }
}

#Preview {
    FlyImagePickerViewModifierPreview()
}

struct FlyImagePicker: UIViewControllerRepresentable {
    let onImagePicked: (UIImage) -> Void
    
    typealias UIViewControllerType = PHPickerViewController
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        let parent: FlyImagePicker
        init(_ parent: FlyImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            let itemProvider = results.first?.itemProvider
            
            if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                    if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            self.parent.onImagePicked(image)
                        }
                    }
                }
            }
        }
    }
}
