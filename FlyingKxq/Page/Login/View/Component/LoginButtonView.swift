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
    let loading: Bool

    init(title: String = "",
         gradientColors: [Color] = [Color(hex: "#27D0C7"), Color(hex: "#25BFB7")],
         cornerRadius: CGFloat = 100,
         textColor: Color = .white,
         borderColor: Color? = nil,
         loading: Bool = false,
         action: (() -> Void)? = nil) {
        self.title = title
        self.action = action
        self.gradientColors = gradientColors
        self.cornerRadius = cornerRadius
        self.textColor = textColor
        self.borderColor = borderColor
        self.loading = loading
    }

    var body: some View {
        Group {
            if let action = action {
                Button(action: action, label: { buttonView })
            } else {
                buttonView
            }
        }
        .disabled(loading)
    }

    private var buttonView: some View {
        ZStack(alignment:.center) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(textColor) // 文字颜色
                .opacity(loading ? 0 : 1)
                .animation(.easeInOut(duration: 0.1), value: loading)
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.white)
                .opacity(loading ? 1 : 0)
        }
        .frame(maxWidth: loading ? 45 : .infinity, minHeight: 45,maxHeight: 45)
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
        .animation(.easeInOut, value: loading)
    }
}

struct LoginButtonViewPreview: View {
    @State private var loading = false
    
    var body: some View {
        LoginButtonView(title: "标题标题标题标题", loading: loading) {
            loading.toggle()
        }
    }
}

#Preview {
    LoginButtonViewPreview()
}
