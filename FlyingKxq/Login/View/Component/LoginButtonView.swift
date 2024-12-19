//
//  LoginButtonView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/17.
//

import SwiftUI

struct LoginButtonView: View {
    let title: String // 按钮显示的文本
    let action: (() -> Void)? // 点击事件回调
    let gradientColors: [Color] // 渐变颜色数组
    let cornerRadius: CGFloat // 圆角大小
    let textColor: Color // 文字色彩
    let borderColor: Color? // 边框色彩

    init(title: String,
         gradientColors: [Color] = [Color(hex: "#27D0C7"), Color(hex: "#25BFB7")],
         cornerRadius: CGFloat = 100,
         textColor: Color = .white,
         borderColor: Color? = nil,
         action: (() -> Void)? = nil) {
        self.title = title
        self.action = action
        self.gradientColors = gradientColors
        self.cornerRadius = cornerRadius
        self.textColor = textColor
        self.borderColor = borderColor
    }

    var body: some View {
        if let action = action {
            Button(action: action, label: { buttonView })
        } else {
            buttonView
        }
    }

    private var buttonView: some View {
        Text(title)
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(textColor) // 文字颜色
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: gradientColors, startPoint: .leading, endPoint: .trailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius)) // 圆角设置
            .overlay {
                if let borderColor = borderColor {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: 2)
                }
            }
    }
}

#Preview {
    LoginButtonView(title: "标题")
}
