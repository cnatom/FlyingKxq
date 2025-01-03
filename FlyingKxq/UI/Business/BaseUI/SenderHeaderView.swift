//
//  SenderHeaderView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/2.
//

import SwiftUI

struct SenderHeaderView: View {
    let avatarUrl: String
    let name: String
    let date: String
    let action: () -> Void
    
    init(avatarUrl: String, name: String, date: String = "", action: @escaping () -> Void) {
        self.avatarUrl = avatarUrl
        self.name = name
        self.date = date
        self.action = action
    }
    
    init(avatarUrl: String, name: String, date: String = "") {
        self.avatarUrl = avatarUrl
        self.name = name
        self.date = date
        self.action = {}
    }
    
    var body: some View {
        HStack(spacing: 0) {
            FlyCachedImageView(url: URL(string: avatarUrl)) { image in
                image
                    .resizable()
                    .clipShape(.circle)
                    .frame(width: 13, height: 13)
            } placeholder: {
                Color.flySecondaryBackground
                    .clipShape(.circle)
                    .frame(width: 13, height: 13)
            }
            Spacer().frame(width: 4)
            Text(name)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color.flyText)
            Spacer().frame(width: 8)
            Text(date)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color.flyGray)
            Spacer()
            FlyIconButton(iconName: "ellipsis", size: 18, iconColor: Color.flyLightGray) {
                action()
            }
        }
    }
}

#Preview {
    SenderHeaderView(avatarUrl: "https://qlogo2.store.qq.com/qzone/1004275481/1004275481/100",
                     name: "张三",
                     date: "3小时前")
}
