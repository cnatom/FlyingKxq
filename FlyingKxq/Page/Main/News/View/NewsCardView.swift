//
//  NewsCardView.swift
//  FlyingKxq
//
//  Created by atom on 2025/2/3.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsCardView: View {
    let time: String
    let source: String?
    let visitCount: Int
    let title: String
    let imageUrl: String?
    let imageText: String?
    
    init(time: String, source: String? = nil, visitCount: Int, title: String, imageUrl: String? = nil,imageText: String? = nil) {
        self.time = time
        self.source = source
        self.visitCount = visitCount
        self.title = title
        self.imageUrl = imageUrl
        self.imageText = imageText
    }

    var body: some View {
        HStack(spacing: 9) {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .lineLimit(2)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color.flyText)
                HStack {
                    Text(time)
                    Spacer()
                    if let source = source {
                        Text(source)
                    }
                    Spacer()
                    Text("浏览 \(visitCount)")
                }
                .lineLimit(1)
                .font(.system(size: 12,weight: .regular))
                .foregroundStyle(Color.flyTextGray)
            }
            if let imageUrl = imageUrl {
                WebImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 89,height: 70,alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } placeholder: {
                    placeHolder
                }
                .transition(.fade(duration: 0.5))
            } else {
                Image("NewsPlaceHolder")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 89,height: 70,alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(alignment: .center) {
                        Text(imageText ?? "")
                            .lineLimit(1)
                            .font(.system(size: 14,weight: .semibold))
                            .foregroundStyle(Color.white)
                    }
            }
        }
    }
    
    var placeHolder: some View {
        RoundedRectangle(cornerRadius: 6)
            .frame(height: 70)
            .frame(width: 89)
            .foregroundStyle(Color.flySecondaryBackground)
    }
}

#Preview {
    NewsCardView(time: "2025-02-03", source: "学校官网·媒体矿大", visitCount: 100, title: "【新华网】《大众篆刻十八讲》研讨会在中国矿业大学举办")
}
