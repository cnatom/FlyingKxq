//
//  ProfileHeaderView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SDWebImageSwiftUI
import SwiftUI

struct ProfileHeaderView<Content: View>: View {
    let imageUrl: String
    let name: String
    let username: String
    let level: Int
    let bio: String
    let fanNumber: Int
    let followNumber: Int
    let likeNumber: Int
    let tags: [ProfileTag]
    let trailingView: Content
    @State var showAddButton = false

    init(avaterUrl: String, name: String, username: String, level: Int, bio: String, fanNumber: Int, followNumber: Int, likeNumber: Int, tags: [ProfileTag], @ViewBuilder trailingView: () -> Content = { EmptyView() }) {
        imageUrl = avaterUrl
        self.name = name
        self.username = username
        self.level = level
        self.bio = bio
        self.fanNumber = fanNumber
        self.followNumber = followNumber
        self.likeNumber = likeNumber
        self.tags = tags
        self.trailingView = trailingView()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 顶端
            HStack(spacing: 0) {
                // 头像
                avatarView

                Spacer().frame(width: 8)

                // 昵称 @用户名
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color.flyText)
                        .lineLimit(1)
                    Text("@\(username)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.flyTextGray)
                }

                Spacer()
                trailingView
            }

            VStack(alignment: .leading, spacing: 12) {
                // 个签
                ProfileTagView(title: "个签", content: bio != "" ? bio : "TA还未设置个性签名")
                HStack(spacing: 10) {
                    // 等级
                    levelView
                    // 状态
                    if tags.count > 1 {
                        scrollableTagsView
                    } else {
                        nonScrollableTagsView()
                    }
                }
                HStack {
                    ProfileTagView(title: "粉丝", content: "\(fanNumber)")
                    ProfileTagView(title: "关注", content: "\(followNumber)")
                    ProfileTagView(title: "获赞", content: "\(likeNumber)")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 24)
    }

    var avatarView: some View {
        let placeHolder = Color.flySecondaryBackground
            .clipShape(.circle)
            .frame(width: 55, height: 55)

        return AsyncImage(url: URL(string: imageUrl), transaction: Transaction(animation: .easeInOut)) { phase in
            switch phase {
            case .empty:
                placeHolder
            case let .success(image):
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(.circle)
                    .frame(width: 55)
            case .failure:
                Image(systemName: "photo.badge.exclamationmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55)
            @unknown default:
                placeHolder
            }
        }
    }

    func nonScrollableTagsView() -> some View {
        return HStack(spacing: 12) {
            ForEach(tags, id: \.title) { result in
                ProfileTagView(title: result.title, content: result.content)
                    .onAppear {
                        withAnimation {
                            self.showAddButton = true
                        }
                    }
            }
            if showAddButton {
                ProfileAddTagButton(showText: true) {
                }
            }
        }
    }

    var scrollableTagsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ProfileAddTagButton(showText: false) {
                }
                ForEach(tags, id: \.title) { result in
                    ProfileTagView(title: result.title, content: result.content)
                }
            }
        }
    }

    var levelView: some View {
        Text("lv.\(level)")
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(Color.flyMain)
            .padding(.horizontal, 12)
            .frame(height: 26)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.flyMain, lineWidth: 1)
            }
    }
}

struct ProfileHeaderTagView: View {
    let tag: ProfileTag

    var body: some View {
        HStack {
            Text(tag.title)
                .font(.system(size: 14))
                .lineLimit(1)
                .foregroundStyle(Color.white)
            Text(tag.content)
                .font(.system(size: 14))
                .lineLimit(1)
                .foregroundStyle(Color.white)
        }
        .padding(8)
        .background(Color.blue)
        .cornerRadius(8)
    }
}

struct ProfileTag: Equatable {
    let title: String
    let content: String
}

struct ProfileHeaderViewPreview: View {
    @State var tags = [ProfileTag(title: "❤️", content: "状态"),
                       ProfileTag(title: "❤️", content: "状态"),
                       ProfileTag(title: "❤️", content: "状态状态")]
    let imageUrl = "https://qlogo2.store.qq.com/qzone/1004275481/1004275481/100"
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Button("添加") {
                    self.tags.append(ProfileTag(title: "❤️", content: "状态New"))
                }
                Button("删除") {
                    if tags.count > 0 {
                        self.tags.removeLast()
                    }
                }
            }
            ProfileHeaderView(
                avaterUrl: imageUrl,
                name: "卖女孩的小火柴",
                username: "username",
                level: 6,
                bio: "我是个性签名",
                fanNumber: 10,
                followNumber: 231,
                likeNumber: 98,
                tags: tags
            )
            ProfileHeaderView(
                avaterUrl: imageUrl,
                name: "卖女孩的小火柴",
                username: "username",
                level: 6,
                bio:"",
                fanNumber: 10,
                followNumber: 231,
                likeNumber: 98,
                tags: [
                    ProfileTag(title: "❤️", content: "动态宽度"),
                ]
            )
            ProfileHeaderView(
                avaterUrl: "",
                name: "卖女孩的小火柴",
                username: "username",
                level: 6,
                bio: "我是个性签名",
                fanNumber: 10,
                followNumber: 231,
                likeNumber: 98,
                tags: [
                ]
            )
        }
    }
}

#Preview {
    ProfileHeaderViewPreview()
}
