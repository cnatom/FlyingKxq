//
//  ProfileEditView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/7.
//

import SwiftUI

struct ProfileEditRowData {
    let title: String
    let content: String?
    let contentView: AnyView
    let destination: AnyView?
    init(title: String, content: String? = nil, contentView: AnyView = AnyView(EmptyView()), destination: AnyView? = nil) {
        self.title = title
        self.content = content
        self.contentView = contentView
        self.destination = destination
    }
}

struct ProfileEditView: View {
    let data: [ProfileEditRowData]

    init(_ data: [ProfileEditRowData]) {
        self.data = data
    }

    var body: some View {
        FlyScaffold {
            VStack(spacing: 0) {
                FlyAppBar(title: "编辑个人信息")
                ScrollView {
                    VStack(spacing: 0) {
                        avaterView
                            .padding(.vertical, 30)
                        ForEach(data,id: \.title) { data in
                            rowContent(title: data.title, content: data.content, contentView: data.contentView,destination: data.destination)
                        }
                        FlyDeviderView()
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }

    @ViewBuilder
    func rowContent<Content: View>(title: String, content: String? = nil, contentView: Content = EmptyView(), destination: AnyView? = nil) -> some View {
        let childView = HStack(alignment: content != nil ? .firstTextBaseline : .center, spacing: 0) {
            Text(title)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(Color.flyTextGray)
                .padding(.trailing, 48)
            Group {
                if let content = content {
                    Text(content)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color.flyText)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        contentView
                    }
                }
            }
            .padding(.trailing, 18)
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .tint(Color.flyGray)
                .scaledToFit()
                .frame(height: 11)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 18)
        VStack(spacing: 0) {
            FlyDeviderView()
            if let destination = destination {
                NavigationLink {
                    destination
                } label: {
                    childView
                }
            } else {
                childView
            }
        }
    }

    @ViewBuilder
    var avaterView: some View {
        let imageView = FlyCachedImageView(url: URL(string: "https://qlogo2.store.qq.com/qzone/1004275481/1004275481/100")) { image in
            image
                .resizable()
                .clipShape(.circle)
                .frame(width: 60, height: 60)
        } placeholder: {
            Color.flySecondaryBackground.clipShape(.circle).frame(width: 60, height: 60)
        }
        Button {
        } label: {
            ZStack(alignment: .bottom) {
                imageView
                Text("编辑")
                    .font(.system(size: 8, weight: .regular))
                    .foregroundStyle(Color.flyTextGray)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 7.5)
                    .background {
                        RoundedRectangle(cornerRadius: 100)
                            .foregroundStyle(Color.flyBackground)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.flySecondaryBackground, lineWidth: 1)
                            )
                    }
                    .offset(y: 5)
            }
        }
    }
}

#Preview {
    ProfileEditView([
        .init(title: "昵称", content: "卖女孩的小火柴"),
        .init(title: "签名", content: "我是签名我是签名我是签名我是签名我是签名我是签名"),
        .init(title: "性别", content: "男"),
        .init(title: "状态", contentView: AnyView(HStack(spacing: 10) {
            ProfileTagView(title: "😉", content: "开心")
            ProfileTagView(title: "😉", content: "开心")
            ProfileTagView(title: "😉", content: "开心")
            ProfileTagView(title: "😉", content: "开心")
        })),

//        rowContent(title: "昵称", content: "卖女孩的小火柴")
//        rowContent(title: "签名", content: "我是签名我是签名我是签名我是签名我是签名我是签名")
//        rowContent(title: "性别", content: "男")
//        rowContent(title: "状态") {
//            HStack(spacing: 10) {
//                ProfileTagView(title: "😉", content: "开心")
//                ProfileTagView(title: "😉", content: "开心")
//                ProfileTagView(title: "😉", content: "开心")
//                ProfileTagView(title: "😉", content: "开心")
//            }
//        }
//        rowContent(title: "家乡", content: "江苏徐州")
//        rowContent(title: "专业", content: "计算机科学与技术")
//        rowContent(title: "年级", content: "")

    ])
}
