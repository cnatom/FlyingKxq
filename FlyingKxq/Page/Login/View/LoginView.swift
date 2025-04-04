//
//  LoginView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/16.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @EnvironmentObject var appState: AuthManager

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            headerView
            inputFields
            loginOptions
            Spacer()
            Group {
                appleSignInButton
                footerLinks
            }
            .modifier(HiddenAnimation(isLoading: viewModel.loginLoading))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .alert(Text(viewModel.loginMessage ?? ""), isPresented: Binding(get: {
            viewModel.loginMessage != nil
        }, set: { _ in

        })) {
            Button("确认") {
                viewModel.loginMessage = nil
            }
        }
    }

    func appleLogin() {
        Task {
            self.appState.isLoggedIn = await viewModel.appleLogin()
        }
    }
}

extension LoginView {
    private var headerView: some View {
        VStack(alignment: .leading) {
            Text("Hi 欢迎使用矿小圈")
                .font(.system(size: 28, weight: .medium))
            Spacer().frame(height: 4)
            Text("矿大人自己的社交空间")
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(Color.flyTextGray)
        }
        .padding(.leading, 26)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 127)
    }

    private var inputFields: some View {
        VStack(spacing: 19) {
            InputView(text: $viewModel.username, placeHolder: "用户名")
                .padding(.horizontal, 32)
            InputView(text: $viewModel.password, textContentType: .password, placeHolder: "密码")
                .padding(.horizontal, 32)
        }
        .disabled(viewModel.loginLoading)
    }

    private var loginOptions: some View {
        VStack(alignment: .center, spacing: 19) {
            LoginButtonView(title: "登录", loading: viewModel.loginLoading) {
                Task {
                    appState.isLoggedIn = await viewModel.login()
                }
            }
            NavigationLink {
                RegisterView()
            } label: {
                LoginButtonView(title: "注册", gradientColors: [Color.clear], textColor: Color.flyMainLight, borderColor: Color.flyMainLight)
            }
            .modifier(HiddenAnimation(isLoading: viewModel.loginLoading))
            .disabled(viewModel.loginLoading)
        }
        .padding(.horizontal, 88)
        .padding(.top, 63)
    }

    private var appleSignInButton: some View {
        Button {
            self.appleLogin()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 100, style: .circular)
                    .foregroundStyle(Color.flyText)
                    .frame(width: 35, height: 35)
                Image(systemName: "apple.logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18)
                    .foregroundStyle(Color.flyBackground)
            }
        }
        .padding(.bottom, 32)
    }

    private var footerLinks: some View {
        HStack {
            Text("隐私政策")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color.flyTextGray)
            Color.flyDevider
                .frame(width: 0.5, height: 10)
            Text("忘记密码")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color.flyTextGray)
        }
    }
}

struct HiddenAnimation: ViewModifier {
    let isLoading: Bool

    func body(content: Content) -> some View {
        content
            .opacity(isLoading ? 0 : 1)
            .scaleEffect(isLoading ? 0.8 : 1, anchor: .top)
            .animation(.easeInOut, value: isLoading)
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthManager.shared)
}
