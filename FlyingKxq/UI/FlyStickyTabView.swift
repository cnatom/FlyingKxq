//
//  FlyStickyTabView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/25.
//

import SwiftUI

struct FlyStickyTabView<Header, Content>: View where Header: View, Content: View {
    @State var headerHeight = 0.0
    @State var headerMinHeight = 0.0
    @State var headerOffset = 0.0
    @State var lastOffset = 0.0
    @State var otherOffset = 0.0
    @State var stickyProgress: CGFloat = 0.0
    @State var scrollViewMap: [Int: UIScrollView] = [:]
    @State var initialOffset: CGFloat?

    var isSticky: Bool {
        stickyProgress == 1.0
    }

    var itemsCount: Int {
        items.count
    }

    var headerMaxOffset: CGFloat {
        -(headerHeight - headerMinHeight)
    }

    @Binding var selectedIndex: Int
    let items: [String]
    let tabBarView: FlyTabBar
    let headerView: Header
    let views: [Content]

    init(selectedIndex: Binding<Int>,
         tabBarType: FlyTabBarItemType = .profile,
         items: [String],
         headerView: Header,
         views: () -> [Content]
    ) {
        _selectedIndex = selectedIndex
        tabBarView = FlyTabBar(selectedIndex: selectedIndex, type: tabBarType, items: items)
        self.items = items
        self.views = views()
        self.headerView = headerView
    }

    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $selectedIndex) {
                ForEach(Array(views.enumerated()), id: \.offset) { index, _ in
                    ScrollView(.vertical, showsIndicators: isSticky) {
                        VStack(spacing: 0) {
                            placeHolder
                            // 垂直内容
                            views[index]
                                .frame(width: self.screenSize.width)
                                .ignoresSafeArea(.all)
                        }
                        .onFrameAppear{ frame in
                            if initialOffset == nil {
                                initialOffset = frame.minY
                            }
                        }
                        .onFrameChange {
                            if isCurrentTab(index) && $0.minX == 0.0 {
                                // 上下偏移量
                                let minY = $0.minY
                                var offsetTemp = minY
                                offsetTemp = max(offsetTemp, headerMaxOffset) // 最大到吸顶位置
                                otherOffset = -offsetTemp + (initialOffset ?? 0.0)
                                print("FrameChange：\(index)调整offset: \(otherOffset)")
                                offsetTemp = min(offsetTemp, 0)
                                headerOffset = offsetTemp
                                stickyProgress = abs(max(offsetTemp, headerMaxOffset) / headerMaxOffset)
                                lastOffset = minY
                            }
                        }
                    }
                    .intro { scrollView in
                        if scrollViewMap[index] == nil {
                            scrollViewMap[index] = scrollView
                        }
                        if !isCurrentTab(index){
                            scrollView.setContentOffset(CGPoint(x: 0, y: otherOffset), animated: false)
                        }
                    }
                    .onChange(of: selectedIndex, perform: { newValue in
                        if let scrollView = scrollViewMap[index] {
                            scrollView.setContentOffset(CGPoint(x: 0, y: otherOffset), animated: false)
                            print("Appear：\(index)设置offset: \(otherOffset)")
                        }
                    })
                    .ignoresSafeArea(.all)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            FlyBlurView()
                .opacity(stickyProgress)
                .frame(height: self.headerHeight + self.headerOffset)
            VStack(spacing: 0) {
                Color.clear.frame(height: self.safeAreaInsets.top)
                headerView
                    .opacity(min(1.0 - stickyProgress, 1.0))
                Spacer().frame(height: 28)
                VStack(spacing: 0) {
                    tabBarView
                    Divider()
                }
                .onSizeAppear {
                    self.headerMinHeight = $0.height + self.safeAreaInsets.top
                }
            }
            .onSizeAppear {
                headerHeight = $0.height
            }
            .offset(y: headerOffset)
        }
        .ignoresSafeArea(.all)
    }

    private func isCurrentTab(_ index: Int) -> Bool {
        return selectedIndex == index
    }

    var placeHolder: some View {
        Color.clear
            .frame(height: headerHeight)
    }
}

struct FlyStickyTabViewPreview: View {
    @State var selectedIndex: Int = 0
    var body: some View {
        FlyStickyTabView(
            selectedIndex: $selectedIndex,
            tabBarType: .profile,
            items: ["消息", "评论", "帖子", "收藏"],
            headerView: headerView,
            views: {
                [
                    itemView(title: "消息"),
                    itemView(title: "评论"),
                    itemView(title: "帖子"),
                    itemView(title: "收藏"),
                ]
            }
        )
    }

    func itemView(title: String) -> some View {
        LazyVStack {
            Text("\(title)")
            ForEach(0 ..< 1000) { index in
                Text("\(index)")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.flySecondaryBackground)
                    .padding(.horizontal)
            }
        }
    }

    var headerView: some View {
        VStack(spacing: 0) {
            Color.flyBackground.frame(height: 30)
            ProfileHeaderView(
                model: .init(
                    avatarUrl: "https://qlogo2.store.qq.com/qzone1004275481/1004275481/100?1727804452",
                    name: "卖女孩的小火柴",
                    username: "username",
                    bio: "我是个性签名",
                    level: 6,
                    fanNumber: 10,
                    followNumber: 231,
                    likeNumber: 98,
                    tags: [
                        ProfileTag(emoji: "❤️", text: "动态宽度"),
                    ]
                )
            )
        }
    }
}

#Preview {
    FlyStickyTabViewPreview()
}
