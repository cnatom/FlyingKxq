//
//  AppbarView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/19.
//

import SwiftUI

struct FlyAppBar: View {
    var title: String = ""
    var showBackButton: Bool = true // 是否显示返回按钮
    var leading: [FlyIconButton] = []
    var action: [FlyIconButton] = []
    var actionView: AnyView? = nil
    var leadingView: AnyView? = nil
    @Environment(\.dismiss) var dismiss // 环境变量用于控制视图返回

    var body: some View {
        ZStack(alignment: .center) {
            HStack(alignment: .center, spacing: 24) {
                if showBackButton {
                    FlyIconButton(iconName: "chevron.backward", size: 16, iconColor: .flyText) {
                        dismiss()
                    }
                }
                if let leadingView = leadingView {
                    leadingView
                }
                ForEach(leading) { lead in
                    lead
                }
                Spacer()
                ForEach(action) { action in
                    action
                }
                if let actionView = actionView {
                    actionView
                }
            }
            Text(title)
                .font(.system(size: 16, weight: .medium))
        }
        .padding(.horizontal, 24)
        .padding(.vertical,12)
        .background(Color.flyBackground)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    VStack {
        FlyAppBar(
            title: "标题",
            action: [
                FlyIconButton(iconName: "ellipsis"),
                FlyIconButton(iconName: "square.and.arrow.up.circle")
            ]
        )
        FlyAppBar(
            title: "标题",
            actionView: AnyView(Text("hello"))
        )
    }
}
