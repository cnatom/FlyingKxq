//
//  FlyTabView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/31.
//

import SwiftUI

struct FlyTabView: View {
    @Binding var selectedIndex: CGFloat
    let views: [AnyView]
    init(selectedIndex: Binding<CGFloat>, views: [AnyView]) {
        self._selectedIndex = selectedIndex
        self.views = views
    }
    
    var itemsCountFloat: CGFloat {
        CGFloat(views.count)
    }
    
    var allPageWidth: CGFloat {
        screenSize.width * itemsCountFloat
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                Color.red.frame(height: 10)
                    .onFrameChange {
                        // 左右偏移量
                        let minX = $0.minX
                        selectedIndex = (-minX / allPageWidth) * itemsCountFloat
                    }
                ForEach(Array(views.enumerated()),id:\.offset) { index,view in
                    view
                        .frame(width: self.screenSize.width)
                        .frame(maxHeight: .infinity)
                    
                }
            }
            
        }
        .intro { scrollView in
            scrollView.isPagingEnabled = true
        }
        .frame(maxHeight: .infinity)
    }
}

struct FlyTabViewPreview: View {
    @State var selectedIndex: CGFloat = 0.0
    
    var body: some View {
        FlyTabView(selectedIndex: $selectedIndex, views: [
            AnyView(Text("首页")),
            AnyView(Text("资讯")),
            AnyView(Text("圈圈")),
            AnyView(Text("我的"))
        ])
    }
}

#Preview {
    FlyTabViewPreview()
}
