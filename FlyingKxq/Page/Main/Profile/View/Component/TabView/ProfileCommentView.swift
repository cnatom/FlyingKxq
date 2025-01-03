//
//  ProfileCommentView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/2.
//

import SwiftUI

struct ProfileCommentView: View {
    var body: some View {
        LazyVStack {
            ForEach(0..<100){_ in
                NewsCommentCard(
                    avatarUrl: "https://qlogo2.store.qq.com/qzone/1004275481/1004275481/100",
                    name: "我",
                    content: "恭喜王老师！",
                    referenceTitle: "计算机学院2024奶奶本科教学高水平成果奖公示",
                    date: "3小时前",
                    footer: "赞 325"
                )
            }
        }
        .padding(.horizontal,24)
    }
}


struct ProfileCommentViewPreview: View {
    var body: some View {
        ProfileCommentView()
    }
}

#Preview {
    ProfileCommentViewPreview()
}
