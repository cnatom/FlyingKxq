//
//  FlySlidingTabView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/25.
//

import SwiftUI

struct FlyTabBar: View {
    @Binding var selectedIndex: CGFloat
    let items: [String]
    let spaceAround: Bool
    let scrollDisabled = false
    let spacing: CGFloat
    let type: FlyTabBarItemType
    @State var itemSize: CGSize? = nil

    init(selectedIndex: Binding<CGFloat>,
         spaceAround: Bool = true,
         spacing: CGFloat = 0,
         type: FlyTabBarItemType = .profile,
         items: [String]
    ) {
        _selectedIndex = selectedIndex
        self.items = items
        self.type = type
        self.spacing = spacing
        self.spaceAround = spaceAround
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(items.indices, id: \.self) { index in
                let selected = Int(selectedIndex.rounded()) == index
                Group {
                    switch type {
                    case .profile:
                        FlyTabBarItemTypeView.profile(text: items[index], selected: selected)
                    case .chip:
                        FlyTabBarItemTypeView.chip(text: items[index], selected: selected)
                    case .news:
                        FlyTabBarItemTypeView.profile(text: items[index], selected: selected,textSize: 16)
                    }
                }
                .padding(.trailing,spacing)
                .animation(.easeInOut, value: selected)
                .frame(maxWidth: spaceAround ? .infinity : nil)
                .background {
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: FlyTabBarItemSizePreferenceKey.self, value: proxy.size)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    smoothScrollTo(targetIndex: CGFloat(index), duration: 0.1)
                }
            }
        }
        .onPreferenceChange(FlyTabBarItemSizePreferenceKey.self, perform: { value in
            self.itemSize = value
        })
        .background {
            indicatorView()
        }
    }

    private func smoothScrollTo(targetIndex: CGFloat, duration: Double) {
        let currentIndex = selectedIndex
        let steps = 50 // 分为 50 步
        let stepDuration = duration / Double(steps) // 每一步的动画时间
        let stepValue = (targetIndex - currentIndex) / CGFloat(steps) // 每一步增加的值

        // 使用 DispatchQueue 实现逐步更新
        for step in 1 ... steps {
            DispatchQueue.main.asyncAfter(deadline: .now() + stepDuration * Double(step)) {
                withAnimation(.easeInOut) {
                    selectedIndex = currentIndex + stepValue * CGFloat(step)
                }
            }
        }
    }

    @ViewBuilder
    func indicatorView() -> some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let count = CGFloat(items.count)
            let itemWidth = width / count
            let offsetX = selectedIndex * (width / count) + itemWidth / 2 - barWidth / 2 - spacing / 2
            Group {
                switch type {
                case .profile:
                    FlyTabBarItemIndicatorView.profile(width: barWidth)
                case .chip:
                    FlyTabBarItemIndicatorView.chip(size: self.itemSize ?? .zero)
                case .news:
                    FlyTabBarItemIndicatorView.profile(width: barWidth)
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .offset(x: offsetX)
        }
    }

    var barWidth: CGFloat {
        switch type {
        case .profile:
            return 20.0
        case .news:
            return 20.0
        case .chip:
            return itemSize?.width ?? 0.0
        }
    }
}

enum FlyTabBarItemType {
    case profile
    case chip
    case news
}

struct FlyTabBarItemSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        let next = nextValue()
        if value == .zero && next != .zero {
            value = next
        }
    }
}

enum FlyTabBarItemTypeView: View {
    case profile(text: String, selected: Bool,textSize:CGFloat = 14)

    case chip(text: String, selected: Bool)

    var body: some View {
        switch self {
        case let .profile(text, selected,textSize):
            let unselectFont = UIFont.systemFont(ofSize: textSize, weight: .medium)
            let textWidth = text.sizeOfFont(uiFont: unselectFont).width
            let barWidth = textWidth < 20 ? 20 : textWidth
            VStack(spacing: 5.5) {
                Text(text)
                    .font(.system(size: textSize, weight: .medium))
                    .foregroundStyle(selected ? Color.flyText : Color.flyTextGray)
                Color.clear
                    .frame(width: barWidth, height: 3)
            }
        case let .chip(text, selected):
            Text(text)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(selected ? Color.flyText : Color.flyTextGray)
                .padding(.horizontal, 10)
                .padding(.vertical, 2)
        }
    }
}

enum FlyTabBarItemIndicatorView: View {
    case profile(width: CGFloat)

    case chip(size: CGSize)

    var body: some View {
        switch self {
        case let .profile(width):
            RoundedRectangle(cornerRadius: 100)
                .frame(width: width, height: 3)
                .foregroundStyle(Color.flyMain)
        case let .chip(size):
            RoundedRectangle(cornerRadius: 100)
                .frame(width: size.width, height: size.height)
                .foregroundStyle(Color.flySecondaryBackground)
        }
    }
}

struct FlyTabBarPreview: View {
    @State private var sliderValue: CGFloat = 1.0 // 默认值为 0.0
    let items = ["消息", "评论", "帖子", "收藏"]
    var body: some View {
        VStack(spacing:40) {
            FlyTabBar(selectedIndex: $sliderValue, spaceAround: false, type: .chip, items: items)
                .padding(.leading,30)
            .frame(maxWidth: .infinity, alignment: .leading)
            FlyTabBar(selectedIndex: $sliderValue, spaceAround: true, type: .profile, items: items)
            FlyTabBar(selectedIndex: $sliderValue, spaceAround: false, spacing: 20, type: .news, items: items)
            FlyTabBar(selectedIndex: $sliderValue, spaceAround: true, spacing: 20, type: .profile, items: items)
            Slider(value: $sliderValue, in: 0.0 ... 3.0, step: 0.01)
                .accentColor(.blue)
                .padding()
        }
    }
}

#Preview {
    FlyTabBarPreview()
}
