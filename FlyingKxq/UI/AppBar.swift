//
//  AppbarView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/19.
//

import SwiftUI

struct AppBar: View {
    var title: String
    var leftButtonAction: (() -> Void)?
    var rightButtonAction: (() -> Void)?
    var showBackButton: Bool = true // 是否显示返回按钮
    @Environment(\.dismiss) var dismiss // 环境变量用于控制视图返回

    var body: some View {
        ZStack(alignment: .center) {
            HStack(alignment: .center) {
                IconButton(iconName: "chevron.backward", size: 16, iconColor: .flyText) {
                    if let leftAction = leftButtonAction {
                        leftAction() // 如果提供了自定义的左侧动作，执行它
                    } else {
                        dismiss.callAsFunction()
                    }
                }
                Spacer()
            }
            Text(title)
                .font(.system(size: 16, weight: .medium))
        }
        .background(Color.flyBackground)
        .frame(maxWidth: .infinity, maxHeight: 52)
    }
}

#Preview {
    AppBar(title: "标题")
}
