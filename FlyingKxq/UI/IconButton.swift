//
//  IconButton.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/19.
//

import SwiftUI

struct IconButton: View {
    let iconName: String        // 图标名称 (系统图标或自定义图标名)
    let action: () -> Void      // 点击事件回调
    let size: CGFloat           // 图标的大小
    let iconColor: Color        // 图标颜色
    let backgroundColor: Color  // 背景颜色
    let cornerRadius: CGFloat   // 按钮圆角半径
    
    init(iconName: String,
         size: CGFloat = 24,
         iconColor: Color = .accentColor,
         backgroundColor: Color = .clear,
         cornerRadius: CGFloat = 100,
         action: @escaping () -> Void) {
        self.iconName = iconName
        self.action = action
        self.size = size
        self.iconColor = iconColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: iconName) // 使用 SF Symbols 图标
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size) // 设置图标尺寸
                .foregroundColor(iconColor) // 图标颜色
                .padding()
                .background(backgroundColor) // 背景颜色
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius)) // 圆角
        }
    }
}
