//
//  ProfileView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SwiftUI

struct ProfileView: View {
    @State var selectedIndex: Int = 0
    @StateObject var viewModel = ProfileHeaderViewModel()
    let items = ["消息", "帖子", "评论", "收藏"]

    var body: some View {
        FlyNavigationView {
            FlyStickyTabView(
                selectedIndex: $selectedIndex,
                tabBarType: .profile,
                items: items,
                headerView: header){
                    [
                        ProfileTabContent.comment,
                        ProfileTabContent.comment,
                        ProfileTabContent.comment,
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
