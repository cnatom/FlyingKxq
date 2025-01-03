//
//  FlyImageView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/2.
//
import SwiftUI
import SDWebImageSwiftUI

struct FlyImageView: View {
    let imageUrl: String
    let size: CGSize
    init(imageUrl: String,size: CGSize = .zero) {
        self.imageUrl = imageUrl
        self.size = size
    }
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: size.width, height: size.height)
        } placeholder: {
            ProgressView().progressViewStyle(.circular)
        }
    }
}

// MARK: - Preview
struct FlyImageViewPreview: View {
    var body: some View {
        FlyImageView(imageUrl: "https://qlogo2.store.qq.com/qzone/1004275481/1004275481/100",size: CGSizeMake(10, 10))
    }
}

struct FlyImageView_Previews: PreviewProvider {
    static var previews: some View {
        FlyImageViewPreview()
    }
}
