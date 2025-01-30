//
//  ProfileHeaderView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SDWebImageSwiftUI
import SwiftUI

struct ProfileHeaderView<Content: View>: View {
    let model: ProfileHeaderModel
    let trailingView: Content
    @State var showAddButton = false

    init(model: ProfileHeaderModel, @ViewBuilder trailingView: () -> Content = { EmptyView() }) {
        self.model = model
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
                    Text(model.name)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color.flyText)
                        .lineLimit(1)
                    Text("@\(model.username)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.flyTextGray)
                }

                Spacer()
                trailingView
            }

            VStack(alignment: .leading, spacing: 12) {
                // 个签
                ProfileTagView(content: model.bio != "" ? model.bio : "TA还未设置个性签名")
                HStack(spacing: 10) {
                    // 等级
                    levelView
                    // 状态
                    scrollableTagsView
                }
                HStack {
                    ProfileTagView(title: "粉丝", content: "\(model.fanNumber)")
                    ProfileTagView(title: "关注", content: "\(model.followNumber)")
                    ProfileTagView(title: "获赞", content: "\(model.likeNumber)")
                }
            }
        }
        .padding(.horizontal, 24)
    }

    var avatarView: some View {
        let placeHolder = Color.flySecondaryBackground
            .clipShape(.circle)
            .frame(width: 55, height: 55)

        return AsyncImage(url: URL(string: model.avatarUrl), transaction: Transaction(animation: .easeInOut)) { phase in
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

    var scrollableTagsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(model.tags, id: \.emoji) { result in
                    ProfileTagView(title: result.emoji, content: result.text)
                }
                if model.tags.count < 3 {
                    addTagButton
                }
            }
        }
    }

    var addTagButton: some View {
        HStack(spacing: 7) {
            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .frame(width: 10)
            Text("状态")
                .font(.system(size: 12, weight: .regular))
        }
        .foregroundStyle(Color.flyGray)
        .frame(height: 26)
        .padding(.horizontal, 16)
        .background {
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.flyLightGray, lineWidth: 1)
        }
    }

    var levelView: some View {
        Text("lv.\(model.level)")
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
            Text(tag.emoji)
                .font(.system(size: 14))
                .lineLimit(1)
                .foregroundStyle(Color.white)
            Text(tag.text)
                .font(.system(size: 14))
                .lineLimit(1)
                .foregroundStyle(Color.white)
        }
        .padding(8)
        .background(Color.blue)
        .cornerRadius(8)
    }
}

struct ProfileHeaderViewPreview: View {
    @State var tags = [ProfileTag(emoji: "❤️", text: "状态"),
                       ProfileTag(emoji: "❤️", text: "状态"),
                       ProfileTag(emoji: "❤️", text: "状态状态")]
    let imageUrl = "https://qlogo2.store.qq.com/qzone/1004275481/1004275481/100"
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Button("添加") {
                    self.tags.append(ProfileTag(emoji: "❤️", text: "状态New"))
                }
                Button("删除") {
                    if tags.count > 0 {
                        self.tags.removeLast()
                    }
                }
            }
            ProfileHeaderView(
                model: .init(
                    avatarUrl: imageUrl,
                    name: "卖女孩的小火柴",
                    username: "username",
                    bio: "",
                    level: 5,
                    fanNumber: 10,
                    followNumber: 231,
                    likeNumber: 98,
                    tags: tags
                )
            )
            ProfileHeaderView(
                model: .init(
                    avatarUrl: imageUrl,
                    name: "卖女孩的小火柴",
                    username: "username",
                    bio: "",
                    level: 5,
                    fanNumber: 10,
                    followNumber: 231,
                    likeNumber: 98,
                    tags: [
                        ProfileTag(emoji: "❤️", text: "动态宽度"),
                    ]
                )
            )
        }
    }
}

#Preview {
    ProfileHeaderViewPreview()
}
