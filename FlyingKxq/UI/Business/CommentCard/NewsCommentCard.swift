//
//  NewsCommentCard.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/2.
//


import SwiftUI

struct NewsCommentCard: View {
    let avatarUrl: String
    let name: String
    let content: String
    let referenceTitle: String
    let date: String
    let footer: String
    let action: () -> Void
    init(avatarUrl: String, name: String, content: String, referenceTitle: String, date: String, footer: String, action: @escaping () -> Void) {
        self.avatarUrl = avatarUrl
        self.name = name
        self.content = content
        self.referenceTitle = referenceTitle
        self.date = date
        self.footer = footer
        self.action = action
    }
    init(avatarUrl: String, name: String, content: String, referenceTitle: String, date: String, footer: String) {
        self.avatarUrl = avatarUrl
        self.name = name
        self.content = content
        self.referenceTitle = referenceTitle
        self.date = date
        self.footer = footer
        self.action = {}
    }
    
    var body: some View {
        VStack(alignment:.leading,spacing: 8) {
            SenderHeaderView(avatarUrl: avatarUrl, name: name,action: action)
            Text(content)
                .font(.system(size: 16,weight: .regular))
                .foregroundStyle(Color.flyText)
            Text(referenceTitle)
                .font(.system(size: 12,weight: .regular))
                .foregroundStyle(Color.flyTextGray)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.vertical,6)
                .padding(.horizontal,12)
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(Color.flySecondaryBackground)
                }
            HStack {
                Text(date)
                    .font(.system(size: 12,weight: .regular))
                    .foregroundStyle(Color.flyTextGray)
                Spacer()
                Text(footer)
                    .font(.system(size: 12,weight: .regular))
                    .foregroundStyle(Color.flyTextGray)
            }
            FlyDeviderView()
            Spacer().frame(height: 0)
        }
        
    }
}

#Preview {
    VStack(spacing:0) {
        NewsCommentCard(
            avatarUrl: "https://qlogo2.store.qq.com/qzone/1004275481/1004275481/100",
            name: "张三",
            content: "恭喜王老师！",
            referenceTitle: "计算机学院2024奶奶本科教学高水平成果奖公示",
            date: "3小时前",
            footer: "赞 325"
        )
        NewsCommentCard(
            avatarUrl: "https://qlogo2.store.qq.com/qzone/1004275481/1004275481/100",
            name: "张三",
            content: "恭喜王老师！",
            referenceTitle: "计算机学院2024奶奶本科教学高水平成果奖公示",
            date: "3小时前",
            footer: "赞 325"
        )
    }
}
