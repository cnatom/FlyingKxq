//
//  PostCard.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/2.
//

import SwiftUI

struct PostCard<Content>: View where Content: View {
    let imageUrl: String
    let name: String
    let date: String
    let title: String?
    let content: String?
    let category: String
    let footer: String
    let childView: Content

    init(imageUrl: String, name: String, date: String, title: String?, content: String?, category: String, footer: String, @ViewBuilder childView: @escaping () -> Content) {
        self.imageUrl = imageUrl
        self.name = name
        self.date = date
        self.title = title
        self.content = content
        self.category = category
        self.footer = footer
        self.childView = childView()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            SenderHeaderView(avatarUrl: imageUrl, name: name, date: date) {
                
            }
            if let title = title {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.flyText)
            }
            if let content = content {
                Text(content)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color(hex: "#494949"))
            }
            childView

            HStack {
                Text(category)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(Color.flyTextGray)
                    .padding(.vertical, 1)
                    .padding(.horizontal, 8)
                    .background {
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundStyle(Color.flySecondaryBackground)
                    }
                Spacer()
                Text(footer)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color.flyTextGray)
            }
            Spacer().frame(height: 1)
            FlyDeviderView()
        }
    }
}

struct PostCardPreview: View {
    let imageUrl = "https://qlogo2.store.qq.com/qzone/1004275481/1004275481/100"
    var body: some View {
        VStack(spacing: 12) {
            PostCard(imageUrl: imageUrl, name: "张三", date: "3小时前", title: "原神下一个池子什么时候出", content: "我是描述我是描述我是描述我是描述我是描述描述描述描述描述", category: "问答", footer: "赞 325  答 10") {
                PostAnswerView(leadingText: "我是答案我是答案我是答案我是答案我是答案我是答案我是答案我是答案我是答案我是答案我是答案我是答案我是答案我是答案", trailingText: "赞 123")
            }
            PostCard(imageUrl: imageUrl, name: "张三", date: "3小时前", title: "原神下一个池子什么时候出", content: "我是描述我是描述我是描述我是描述我是描述描述描述描述描述", category: "杂谈", footer: "赞 325  答 10") {
                PostImageListView(imageUrls: [
                    imageUrl, imageUrl, imageUrl, imageUrl,
                ])
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    PostCardPreview()
}
