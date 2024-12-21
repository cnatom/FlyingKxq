//
//  MainTabView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("首页", systemImage: "house")
                }
                .tag(0)
            
            ProfileView()
                .tabItem {
                    Label("我的", systemImage: "person")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Label("设置", systemImage: "gear")
                }
                .tag(2)
        }
    }
}

struct HomeView: View {
    var body: some View {
        Text("首页内容")
    }
}

struct ProfileView: View {
    var body: some View {
        Text("我的内容")
    }
}

struct SettingsView: View {
    var body: some View {
        Text("设置内容")
    }
}

#Preview {
    MainTabView()
}
