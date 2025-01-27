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
    @EnvironmentObject var viewModel: ProfileHeaderViewModel
    @EnvironmentObject var toast: ToastViewModel

    func editProfile(_ value: String, type: UserInfoEditType) {
        Task {
            toast.start("修改中")
            let result = await viewModel.editProfile(type: type, value: value)
            toast.end(result)
        }
    }

    var data: [ProfileEditRowData] { [
        .init(title: "昵称",
              content: viewModel.model.name,
              destination: AnyView(
                  TextEditerView(
                      text: viewModel.model.name,
                      appBarTitle: "编辑昵称",
                      maxLength: 36
                  ) { value in
                      editProfile(value, type: .nickname)
                  }
              )
        ),
        .init(title: "签名",
              content: viewModel.model.bio,
              destination: AnyView(
                  TextEditerView(
                      text: viewModel.model.bio,
                      appBarTitle: "编辑签名"
                  ) { value in
                      editProfile(value, type: .bio)
                  }
              )),
        .init(title:
            "性别",
            content: viewModel.model.gender,
            destination: AnyView(
                EnumEditerView(
                    title: "修改性别",
                    onSave: { value in
                        editProfile(value, type: .gender)
                    },
                    current: EnumEditerItemString(viewModel.model.gender),
                    enums: ["男", "女", "保密"]
                )
            )
        ),
        .init(title: "状态",
              contentView: AnyView(HStack(spacing: 10) {
                  ForEach(viewModel.model.tags) { tag in
                      ProfileTagView(title: tag.emoji, content: tag.text)
                  }
              }),
              destination: AnyView(TagEditerView().environmentObject(viewModel))
        ),
        .init(title: "家乡",
              content: viewModel.model.hometown,
              destination: AnyView(
                  TextEditerView(
                      text: viewModel.model.hometown,
                      appBarTitle: "编辑家乡"
                  ) { value in
                      editProfile(value, type: .hometown)
                  }
              )),
        .init(title: "专业",
              content: viewModel.model.major,
              destination: AnyView(
                  TextEditerView(
                      text: viewModel.model.major,
                      appBarTitle: "编辑专业"
                  ) { value in
                      editProfile(value, type: .major)
                  }
              )),
        .init(title: "年级",
              content: viewModel.model.grade,
              destination: AnyView(
                  TextEditerView(
                      text: viewModel.model.grade,
                      appBarTitle: "编辑年级"
                  ) { value in
                      editProfile(value, type: .grade)
                  }
              )),
    ] }

    var body: some View {
        FlyScaffold {
            VStack(spacing: 0) {
                FlyAppBar(title: "编辑个人信息")
                ScrollView {
                    VStack(spacing: 0) {
                        avaterView
                            .padding(.vertical, 30)
                        ForEach(data, id: \.title) { data in
                            rowContent(title: data.title, content: data.content, contentView: data.contentView, destination: data.destination)
                        }
                        FlyDeviderView()
                    }
                }
            }
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
                .foregroundStyle(Color.flyGray)
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
    ProfileEditView()
        .environmentObject(ProfileHeaderViewModel())
}
