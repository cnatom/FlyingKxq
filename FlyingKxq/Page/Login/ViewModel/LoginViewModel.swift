//
//  LoginViewModel.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/17.
//

import AuthenticationServices
import Foundation

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var loginMessage: String? = nil

    var loginResponse: LoginResponse?

    // MARK: 登录

    func login() async -> Bool {
        if let validMessage = isValid() {
            DispatchQueue.main.async {
                self.loginMessage = validMessage
            }
            return false
        }

        let api = LoginAPI()
        api.parameters = [
            "username": username,
            "password": password,
        ]

        do {
            // 异步请求登录 API
            let response: LoginResponse = try await NetworkManager.shared.request(api: api, responseType: LoginResponse.self)
            loginResponse = response
            if response.code == 200 {
                updateUI { self.loginMessage = "登录成功！" }
                return true
            } else {
                updateUI { self.loginMessage = response.msg }
                return false
            }
        } catch {
            // 处理错误
            updateUI { self.loginMessage = "登录失败：\(error.localizedDescription)" }
            return false
        }
    }

    // MARK: Apple登录

    func appleLogin() async -> Bool {
        var authorizationCodeString: String?
        do {
            let result = try await AppleSignInUtil.shared.startAppleSignIn()
            authorizationCodeString = result.authorizationCodeString
        } catch {
            updateUI { self.loginMessage = "Apple 登录失败：\(error.localizedDescription)" }
            return false
        }

        guard let code = authorizationCodeString else {
            updateUI { self.loginMessage = "Apple 登录授权失败" }
            return false
        }

        let api = AppleLoginAPI()
        api.parameters["appleAuthorizationCode"] = code

        do {
            let response: LoginResponse = try await NetworkManager.shared.request(api: api, responseType: LoginResponse.self)
            loginResponse = response
            if response.code == 200 {
                updateUI { self.loginMessage = "登录成功！" }
                return true
            } else {
                loginMessage = response.msg
                return false
            }
        } catch {
            updateUI { self.loginMessage = "登录失败：\(error.localizedDescription)" }

            return false
        }
    }

    // MARK: 输入校验

    private func isValid() -> String? {
        guard username != "" else { return "请输入用户名" }
        guard password != "" else { return "请输入密码" }
        return nil
    }
}
