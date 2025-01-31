//
//  MainTabView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 1

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(0)
                NewsView()
                    .tag(1)
                ChatView()
                    .tag(2)
                ProfileView()
                    .tag(3)
            }
            FlyNavigationBar(selectedItem: $selectedTab, leftItems: ["首页", "资讯"], rightItems: ["圈圈", "我的"]) {
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea(edges: .vertical)
    }
}

#Preview {
    MainTabView()
}
