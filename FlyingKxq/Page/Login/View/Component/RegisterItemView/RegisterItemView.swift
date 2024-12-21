//
//  RegisterItemView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/20.
//

import SwiftUI

struct RegisterItemView: View {
    let model: RegisterItemModel

    init(model: RegisterItemModel) {
        self.model = model
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(model.description)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color.flyTextGray)
                .multilineTextAlignment(.leading)
            switch model.type {
            case .Button:
                LoginButtonView(
                    title: model.title,
                    gradientColors: [Color.clear],
                    textColor: model.buttonColor ?? Color.flyMainLight,
                    borderColor: model.buttonColor ?? Color.flyMainLight,
                    action: model.action
                )
                .animation(.easeInOut, value: model.title)
            case .Input:
                InputView(
                    text: model.$inputText,
                    placeHolder: model.title
                )
            }
        }
    }
}

#Preview {
    VStack {
        RegisterItemView(model: RegisterItemModel(description: "描述", type: .Input, title: "标题"))
        RegisterItemView(model: RegisterItemModel(description: "描述", type: .Button, title: "标题"))

    }
}
