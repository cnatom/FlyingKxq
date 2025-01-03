//
//  RegisterView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/19.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    @EnvironmentObject var appState: AuthManager

    var body: some View {
        FlyScaffold {
            VStack(alignment: .center, spacing: 0, content: {
                FlyAppBar(title: "注册")
                ScrollView {
                    Group {
                        Spacer().frame(height: 52)
                        VStack(alignment: .center, spacing: 20) {
                            NavigationLink {
                                SchoolCertificationView(viewModel: viewModel)
                            } label: {
                                RegisterItemView(model: .init(
                                    description: "请先点击下方按钮认证，证明您是矿大师生",
                                    type: .Button,
                                    title: viewModel.schoolCertificationStatus))
                            }
                            RegisterItemView(model: .init(
                                description: "设置用户名（6-16位，英文数字下划线组成）",
                                type: .Input,
                                title: "用户名",
                                inputText: $viewModel.username))
                            RegisterItemView(model: .init(
                                description: "设置密码（8-20位，无空格）",
                                type: .Input,
                                title: "密码",
                                inputText: $viewModel.password))
                            RegisterItemView(model: .init(
                                description: "请重新输入刚刚的密码以确认",
                                type: .Input,
                                title: "确认密码",
                                inputText: $viewModel.passwordConfirm))
                            RegisterItemView(model: .init(
                                description: "(可选)绑定Apple ID，下次可以直接用Apple登录",
                                type: .Button,
                                title: viewModel.appleBindStatus,
                                buttonColor: Color.flyText
                            ) {
                                viewModel.appleAccountBind()
                            })
                            
                        }
                        .disabled(viewModel.loading)
                        Spacer().frame(height: 79)
                        LoginButtonView(title: "注册并登录",loading: viewModel.loading) {
                            Task {
                                appState.isLoggedIn = await viewModel.register()
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 32)
                }
            })
            .alert(Text(viewModel.alertText ?? ""), isPresented: Binding(get: {
                viewModel.alertText != nil
            }, set: { _ in
            })) {
                Button("确定") {
                    viewModel.alertText = nil
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
