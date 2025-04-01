//
//  NewsView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SwiftUI

struct NewsView: View {
    @StateObject var viewModel = NewsViewModel()
    @State var tabBar1Height: CGFloat = 0 // 一级分类的高度
    @State var tabBar2Height: CGFloat = 0 // 二级分类的未缩减高度
    let tabBarSpacing: CGFloat = 10
    // 顶栏实际的高度
    var tabBarHeight: CGFloat {
        tabBar1Height + tabBar2Height + safeAreaInsets.top + tabBarSpacing
    }
    
    @State var tabBar2OffsetY: CGFloat = 0 // 二级分类的高度偏移量
    @State var scrollViewDelegate: NewsScrollViewDelegate?
    var tabBar2OffsetProgress: CGFloat {
        tabBar2OffsetY / tabBar2Height
    }
    
    var enableTabViewScroll: Bool {
        tabBar2OffsetProgress > 0.5
    }
    
    var body: some View {
        FlyScaffold {
            ZStack(alignment: .top) {
                firstTabBar // 一级分类的视图
                TabView(selection: $viewModel.index1) {
                    ForEach(viewModel.model.tab1List.indices, id: \.self) { index1 in
                        ZStack(alignment: .top) {
                            secondTabBar // 二级分类的视图
                            TabView(selection: $viewModel.index3) {
                                ForEach(viewModel.model.tab3List(index1: index1, index2: 0).indices, id: \.self) { index3 in
                                    let listModel = viewModel.model.listModel(index1: index1, index2: 0, index3: index3)
                                    listView(model: listModel) // 新闻列表视图
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
            viewModel.getNewsType() // 获取新闻分类
            // 根据滑动偏移量调整二级分类的显示
            scrollViewDelegate = NewsScrollViewDelegate(onDeltaChange: { offsetY in
                tabBar2OffsetY += offsetY
                tabBar2OffsetY = min(max(tabBar2OffsetY, 0), tabBar2Height) // 限制偏移量在有效范围内
            })
        }
        .ignoresSafeArea(.all, edges: .top)
    }
    
    // MARK: 学院、学校 分类
    var firstTabBar: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: self.safeAreaInsets.top) // 顶部安全区的间距
            HStack {
                FlyTabBar(selectedIndex: $viewModel.index1,
                          spaceAround: false,
                          spacing: 16,
                          type: .news,
                          items: viewModel.model.tab1List)
                .onChange(of: viewModel.index1) { _ in
                    withAnimation(.none) {
                        viewModel.index3 = 0 // 每次一级分类切换时，重置二级分类索引
                    }
                }
                Spacer()
                Image(systemName: "magnifyingglass") // 搜索图标
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 10)
            .onSizeAppear { size in
                tabBar1Height = size.height // 获取一级分类的高度
            }
        }
        .zIndex(1) // 确保一级分类在最上层
    }
    
    // MARK: 二级分类
    var secondTabBar: some View {
        Group {
            VStack(spacing: 0) {
                // 将二级分类顶到一级分类的下面
                Spacer().frame(height: tabBar1Height + self.safeAreaInsets.top + tabBarSpacing)
                // 二级分类
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        HStack(spacing: 0) {
                            FlyTabBar(selectedIndex: $viewModel.index3,
                                      spaceAround: false,
                                      spacing: 10,
                                      type: .chip,
                                      items: viewModel.model.tab3List(index1: viewModel.index1, index2: viewModel.index2))
                        }
                        .onChange(of: viewModel.index3) { newValue in
                            withAnimation {
                                proxy.scrollTo(newValue, anchor: .center) // 滚动到选中的二级分类
                            }
                        }
                        .padding(.leading, 11)
                    }
                }
                .padding(.leading, 11)
                .padding(.trailing, 16)
                .padding(.bottom, 5)
                .opacity(1 - tabBar2OffsetProgress) // 根据偏移量调整透明度
                .onSizeAppear { size in
                    tabBar2Height = size.height // 获取二级分类的高度
                }
            }
            .mask(alignment: .top) {
                Rectangle().frame(height: tabBarHeight - tabBar2OffsetY) // 创建遮罩以显示偏移效果
            }
            .zIndex(2) // 确保二级分类在一级分类之上
            .ignoresSafeArea(.all, edges: .top)
            
            Spacer().frame(height: tabBarHeight - tabBar2OffsetY) // 为背景模糊效果留出空间
                .flyBlurBackground(tint: Color.flyBackground.opacity(0.2)) // 模糊背景
                .ignoresSafeArea(.all, edges: .top)
                .zIndex(1) // 确保背景在二级分类之下
        }
    }
    
    // MARK: 新闻列表
    func listView(model: NewsListModel) -> some View {
        ScrollView {
            VStack(spacing: 0) {
                Spacer().frame(height: tabBarHeight + 19) // 为列表留出顶部空间
                NewsListView(model: model) // 新闻列表视图
            }
        }
        .intro(customize: { scrollView in
            // 监听列表的滑动偏移量
            scrollView.delegate = self.scrollViewDelegate
        })
        .ignoresSafeArea(.all, edges: .top)
        .id(model.sourceName) // 为列表视图设置唯一标识
    }
}

class NewsScrollViewDelegate: NSObject, UIScrollViewDelegate {
    private var lastContentOffsetY: CGFloat = 0
    private let onDeltaChange: (CGFloat) -> Void
    
    init(onDeltaChange: @escaping (CGFloat) -> Void) {
        self.onDeltaChange = onDeltaChange
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffsetY = scrollView.contentOffset.y // 记录当前偏移量
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newContentOffsetY = scrollView.contentOffset.y
        let delta = newContentOffsetY - lastContentOffsetY // 计算偏移量变化
        if newContentOffsetY > 0 {
            onDeltaChange(delta) // 当列表滚动时，触发偏移量变化
        }
        lastContentOffsetY = newContentOffsetY // 更新最后的偏移量
    }
}

#Preview {
    NewsView()
        .environmentObject(ToastViewModel())
}
