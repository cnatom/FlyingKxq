//
//  RegisterView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/19.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            AppBar(title: "注册")
            ScrollView {
                Group {
                    Spacer().frame(height: 52)
                    VStack(alignment: .center, spacing: 20) {
                        // 渲染所有 RegisterItemModel
                        RegisterItemView(model: viewModel.schoolCertificationItem)
                        RegisterItemView(model: viewModel.usernameItem)
                        RegisterItemView(model: viewModel.passwordItem)
                        RegisterItemView(model: viewModel.passwordConfirmItem)
                        RegisterItemView(model: viewModel.appleAccountBindItem)
                    }
                    Spacer().frame(height: 79)
                    LoginButtonView(title: "注册并登录")
                    Spacer()
                }
                .padding(.horizontal,32)
            }
        })
        
    }
    
    private func RegisterItemView(model: RegisterItemModel) -> some View {
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
                    borderColor: model.buttonColor ?? Color.flyMainLight
                )
            case .Input:
                InputView(
                    text: Binding(
                        get: { model.value },
                        set: { model.value = $0 }
                    ),
                    placeHolder: model.title
                )
            }
        }
    }
}

#Preview {
    RegisterView()
}
