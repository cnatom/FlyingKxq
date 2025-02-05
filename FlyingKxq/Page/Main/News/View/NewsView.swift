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
    @State var tabBar2Height: CGFloat = 0
    var tabBarHeight: CGFloat {
        tabBar1Height + tabBar2Height + safeAreaInsets.top + 10
    }

    @State var tabBar2OffsetYLast: CGFloat = 0
    @State var tabBar2OffsetY: CGFloat = 0
    @State var scrollViewDelegate: NewsScrollViewDelegate?
    var tabBar2OffsetProgress: CGFloat {
        return tabBar2OffsetY / tabBar2Height
    }

    var enableTabViewScroll: Bool {
        tabBar2OffsetProgress > 0.5
    }

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
                                    .opacity(1 - tabBar2OffsetProgress)
                                    .onSizeAppear { size in
                                        tabBar2Height = size.height
                                    }
                            }
                            .mask(alignment: .top, {
                                Rectangle().frame(height: tabBarHeight - tabBar2OffsetY)
                            })
                            .zIndex(2)
                            .ignoresSafeArea(.all, edges: .top)

                            Spacer().frame(height: tabBarHeight - tabBar2OffsetY)
                                .flyBlurBackground(tint: Color.flyBackground.opacity(0.2))
                                .ignoresSafeArea(.all, edges: .top)
                                .zIndex(1)

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
                                    .intro(customize: { scrollView in
                                        scrollView.delegate = self.scrollViewDelegate
                                    })
                                    .ignoresSafeArea(.all, edges: .top)
                                    .id(index3)
                                }
                            }
                            .ignoresSafeArea(.all, edges: .top)
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
        .onAppear {
            viewModel.getNewsType()
            scrollViewDelegate = NewsScrollViewDelegate(onDeltaChange: { offsetY in
                tabBar2OffsetY += offsetY
                tabBar2OffsetY = min(max(tabBar2OffsetY, 0), tabBar2Height)
            })
        }
        .ignoresSafeArea(.all, edges: .top)
    }

    var tabBar1: some View {
        HStack {
            FlyTabBar(selectedIndex: $viewModel.index1, spaceAround: false, spacing: 16, type: .news, items: viewModel.model.tab1List)
                .onChange(of: viewModel.index1) { _ in
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
class NewsScrollViewDelegate: NSObject, UIScrollViewDelegate {
    private var lastContentOffsetY: CGFloat = 0
    private let onDeltaChange: (CGFloat) -> Void
    
    init(onDeltaChange: @escaping (CGFloat) -> Void) {
        self.onDeltaChange = onDeltaChange
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffsetY = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newContentOffsetY = scrollView.contentOffset.y
        let delta = newContentOffsetY - lastContentOffsetY
        if newContentOffsetY > 0 {
            onDeltaChange(delta)
        }
        lastContentOffsetY = newContentOffsetY
    }
}

#Preview {
    NewsView()
        .environmentObject(ToastViewModel())
}
