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
                        ProfileEditView()
                            .environmentObject(viewModel)
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
