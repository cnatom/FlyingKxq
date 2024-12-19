//
//  ContentView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/16.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                headerView
                inputFields
                loginOptions
                Spacer()
                appleSignInButton
                footerLinks
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }

    // MARK: - Header Section

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

    // MARK: - Input Fields

    private var inputFields: some View {
        VStack(spacing: 19) {
            InputView(text: $username, placeHolder: "用户名")
                .padding(.horizontal, 32)
            InputView(text: $password, textContentType: .password, placeHolder: "密码")
                .padding(.horizontal, 32)
        }
    }

    // MARK: - Login/Registration Options

    private var loginOptions: some View {
        VStack(alignment: .center, spacing: 19) {
            LoginButtonView(title: "登录") {
                print("登录")
            }
            LoginButtonView(title: "注册", gradientColors: [Color.clear], textColor: Color.flyMainLight, borderColor: Color.flyMainLight) {
                print("注册")
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 63)
    }

    // MARK: - Apple SignIn Button

    private var appleSignInButton: some View {
        Button {
            viewModel.startAppleSignIn()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 100, style: .circular)
                    .foregroundStyle(Color.flyText)
                    .frame(width: 35, height: 35)
                Image(systemName: "apple.logo")
                    .foregroundStyle(Color.flyBackground)
            }
        }
        .padding(.bottom, 32)
    }

    // MARK: - Footer Links

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

#Preview {
    LoginView()
}
