//
//  MainTabView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 3

    private let tabs: [Int: AnyView] = [
        0: AnyView(HomeView()),
        1: AnyView(NewsView()),
        2: AnyView(ChatView()),
        3: AnyView(ProfileView()),
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            tabs[selectedTab]
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            FlyNavigationBar(selectedItem: $selectedTab, leftItems: ["首页", "资讯"], rightItems: ["圈圈", "我的"]) {
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea(edges:.bottom)
    }
}

#Preview {
    MainTabView()
}
