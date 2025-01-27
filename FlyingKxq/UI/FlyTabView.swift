//
//  FlyTabView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/25.
//

import SwiftUI

struct FlyTabView<Header, Content>: View where Header: View, Content: View {
    @State var headerHeight = 0.0
    @State var headerMinHeight = 0.0
    @State var headerOffset = 0.0
    @State var lastOffset = 0.0
    @State var otherOffset = 0.0
    @State var stickyProgress: CGFloat = 0.0
    let selectedIndexCallBack: (Int) -> Void
    @State var selectedIndexCallBackLock: Int = -1 // 防止selectedIndexCallBack在同一页面上多次调用
    
    var isSticky: Bool {
        stickyProgress == 1.0
    }

    var allPageWidth: CGFloat {
        screenSize.width * itemsCountFloat
    }

    var itemsCountFloat: CGFloat {
        CGFloat(items.count)
    }

    var headerMaxOffset: CGFloat {
        -(headerHeight - headerMinHeight)
    }

    @Binding var selectedIndex: CGFloat
    let items: [String]
    let tabBarView: FlyTabBar
    let headerView: Header
    let views: [Content]

    init(selectedIndex: Binding<CGFloat>,
         tabBarType: FlyTabBarItemType = .profile,
         items: [String],
         headerView: Header,
         selectedIndexCallBack: @escaping (Int) -> Void = {_ in },
         views: () -> [Content]
    ) {
        _selectedIndex = selectedIndex
        tabBarView = FlyTabBar(selectedIndex: selectedIndex, type: tabBarType, items: items)
        self.items = items
        self.views = views()
        self.headerView = headerView
        self.selectedIndexCallBack = selectedIndexCallBack
    }

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.horizontal,showsIndicators: false) {
                VStack(spacing: 0) {
                    Color.clear.frame(height: 0)
                        .onFrameChange {
                            // 左右偏移量
                            let minX = $0.minX
                            selectedIndex = (-minX / allPageWidth) * itemsCountFloat
                        }
                    HStack(spacing: 0) {
                        ForEach(Array(views.enumerated()), id: \.offset) { index, _ in
                            ScrollView(.vertical, showsIndicators: isSticky) {
                                placeHolder
                                    .onFrameChange {
                                        if isCurrentTab(index) && $0.minX == 0.0 {
                                            // 上下偏移量
                                            let minY = $0.minY
                                            var offsetTemp = minY
                                            offsetTemp = max(offsetTemp, headerMaxOffset) // 最大到吸顶位置
                                            otherOffset = -offsetTemp
                                            offsetTemp = min(offsetTemp, 0)
                                            headerOffset = offsetTemp
                                            stickyProgress = abs(max(offsetTemp, headerMaxOffset) / headerMaxOffset)
                                            lastOffset = minY
                                        }
                                    }
                                // 垂直内容
                                views[index]
                                    .frame(width: self.screenSize.width)
                                    .frame(minHeight: self.screenSize.height, alignment: .top)
                            }
                            .intro { scrollView in
                                // 横向滚动结束时，将其他页面切换到当前页面的上下偏移量
                                if selectedIndex.isInteger && !isCurrentTab(index) {
                                    scrollView.setContentOffset(CGPoint(x: 0, y: otherOffset), animated: false)
                                }
                            }
                        }
                    }
                }
            }
            .intro { scrollView in
                scrollView.isPagingEnabled = true
                let selectedIndexInt = Int(selectedIndex)
                if  selectedIndex.isInteger && selectedIndexInt != selectedIndexCallBackLock{
                    self.selectedIndexCallBack(selectedIndexInt)
                    selectedIndexCallBackLock = selectedIndexInt
                    scrollView.setContentOffset(CGPoint(x: selectedIndex * self.screenSize.width, y: 0), animated: false)
                }
            }
            FlyBlurView()
                .opacity(stickyProgress)
                .frame(height: self.headerHeight + self.headerOffset)
            VStack(spacing: 0) {
                Color.clear.frame(height: self.safeAreaInsets.top)
                headerView
                    .opacity(min(1.0 - stickyProgress, 0.8))
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
            Color.clear
                .frame(height: self.safeAreaInsets.top)
        }
        .ignoresSafeArea(.all, edges: .top)
    }

    private func isCurrentTab(_ index: Int) -> Bool {
        return selectedIndex.toInteger == index
    }

    var placeHolder: some View {
        Color.clear
            .frame(height: headerHeight)
    }
}

struct FlyTabViewPreview: View {
    @State var selectedIndex: CGFloat = 0.0
    var body: some View {
        FlyTabView(
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
    FlyTabViewPreview()
}
