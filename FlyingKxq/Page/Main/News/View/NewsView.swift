//
//  NewsView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SwiftUI

struct NewsView: View {
    @StateObject var viewModel = NewsViewModel()
    @State var tabBar1Height: CGFloat = 0
    @State var tabBarHeight: CGFloat = 0

    var body: some View {
        FlyScaffold {
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    // 校园、学院
                    Spacer().frame(height: self.safeAreaInsets.top)
                    tabBar1
                        .onSizeAppear { size in
                            tabBar1Height = size.height
                        }
                }
                .zIndex(1)
                TabView(selection: $viewModel.index1) {
                    ForEach(viewModel.model.tab1List.indices, id: \.self) { index1 in
                        ZStack(alignment: .top) {
                            VStack(spacing: 0) {
                                Spacer().frame(height: tabBar1Height + self.safeAreaInsets.top + 10)
                                tabBar3
                            }
                            .flyBlurBackground(tint: Color.flyBackground.opacity(0.2))
                            .onSizeAppear { size in
                                tabBarHeight = size.height
                            }
                            .zIndex(1)
                            .ignoresSafeArea(.all, edges: .top)
                            TabView(selection: $viewModel.index3) {
                                ForEach(viewModel.model.tab3List(index1: index1, index2: 0).indices, id: \.self) { index3 in
                                    ScrollView {
                                        VStack(spacing: 0) {
                                            Spacer().frame(height: tabBarHeight + 19)
                                            NewsListView(model: viewModel.model.listModel(
                                                index1: index1,
                                                index2: 0,
                                                index3: index3
                                            ))
                                        }
                                    }
                                    .ignoresSafeArea(.all, edges: .top)
                                    .id(index3)
                                }
                            }
                            .ignoresSafeArea(.all, edges: .top)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
        .onAppear {
            viewModel.getNewsType()
        }
        .ignoresSafeArea(.all, edges: .top)
    }

    var tabBar1: some View {
        HStack {
            FlyTabBar(selectedIndex: $viewModel.index1, spaceAround: false, spacing: 16, type: .news, items: viewModel.model.tab1List)
            .onChange(of: viewModel.index1) { newValue in
                withAnimation(.none) {
                    viewModel.index3 = 0
                }
            }
            Spacer()
            Image(systemName: "magnifyingglass")
        }
        .padding(.horizontal, 18)
        .padding(.bottom, 10)
    }

    var tabBar3: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                HStack(spacing: 0) {
                    FlyTabBar(selectedIndex: $viewModel.index3, spaceAround: false, spacing: 10, type: .chip, items: viewModel.model.tab3List(index1: viewModel.index1, index2: viewModel.index2))
                }
                .onChange(of: viewModel.index3) { newValue in
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .center)
                    }
                }
                .padding(.leading, 11)
            }
        }
        .padding(.leading, 11)
        .padding(.trailing, 16)
        .padding(.bottom, 5)
    }
}

#Preview {
    NewsView()
        .environmentObject(ToastViewModel())
}
