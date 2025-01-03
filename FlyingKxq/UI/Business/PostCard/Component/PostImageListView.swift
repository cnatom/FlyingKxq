//
//  PostImageView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/2.
//

import SwiftUI

struct PostImageListView: View {
    let imageUrls: [String]
    init(imageUrls: [String] = []) {
        self.imageUrls = imageUrls
    }
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack(spacing:8) {
                ForEach(imageUrls,id: \.self) {url in
                    FlyCachedImageView(url: URL(string: url)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 8))
                            .frame(width: 109,height: 109)
                    } placeholder: {
                        Color.flySecondaryBackground
                            .clipShape(.rect(cornerRadius: 8))
                            .frame(width: 109,height: 109)
                    }
                    
                }
            }
            
        }
        .clipShape(.rect(cornerRadius: 8))
    }
}

#Preview {
    let imageUrl = "https://qlogo2.store.qq.com/qzone/1004275481/1004275481/100"
    PostImageListView(imageUrls: [
        imageUrl,imageUrl,imageUrl,imageUrl
    ])
}
