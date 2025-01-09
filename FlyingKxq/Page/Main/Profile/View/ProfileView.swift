//
//  ProfileView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SwiftUI
@_spi(Advanced) import SwiftUIIntrospect

struct ProfileView: View {
    @State var selectedIndex: CGFloat = 0.0
    @StateObject var viewModel = ProfileHeaderViewModel()
    let items = ["消息", "帖子", "评论", "收藏"]

    var body: some View {
        FlyNavigationView {
            FlyTabView(
                selectedIndex: $selectedIndex,
                tabBarType: .profile,
                items: items,
                headerView: header,
                selectedIndexCallBack: { _ in

                }) {
                    [
                        ProfileTabContent.comment,
                        ProfileTabContent.text("Hello"),
                        ProfileTabContent.post(AnyView(Text("Hello2"))),
                        ProfileTabContent.comment,
                    ]
                }
        }
    }

    var header: some View {
        VStack(spacing: 0) {
            FlyAppBar(
                title: "",
                showBackButton: false,
                action: [FlyIconButton(iconName: "ellipsis", iconColor: Color.flyTextGray)]
            )
            ProfileHeaderView(
                model: viewModel.model,
                trailingView: {
                    NavigationLink {
                        ProfileEditView([
                            .init(title: "昵称",
                                  content: viewModel.model.name,
                                  destination: AnyView(
                                      TextEditerView(
                                          text: viewModel.model.name,
                                          appBarTitle: "编辑昵称",
                                          maxLength: 36
                                      ) { viewModel.model.name = $0 }
                                  )
                            ),
                            .init(title: "签名",
                                  content: viewModel.model.bio,
                                  destination: AnyView(
                                      TextEditerView(
                                          text: viewModel.model.bio,
                                          appBarTitle: "编辑签名"
                                      ) { viewModel.model.bio = $0 }
                                  )),
                            .init(title: "性别", content: "男"),
                            .init(title: "状态", contentView: AnyView(HStack(spacing: 10) {
                                ProfileTagView(title: "😉", content: "开心")
                                ProfileTagView(title: "😉", content: "开心")
                                ProfileTagView(title: "😉", content: "开心")
                                ProfileTagView(title: "😉", content: "开心")
                            })),
                        ])
                        .onAppear {
                            print("出现: ProfileEditView")
                        }
                        .onDisappear {
                            print("消失: ProfileEditView")
                        }
                    } label: {
                        ProfileChipButton(title: "编辑资料", primary: false)
                    }
                }
            )
            .onAppear {
                Task {
                    let _ = await viewModel.getData()
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
