//
//  LoginViewModel.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/17.
//

import AuthenticationServices
import Foundation

class LoginViewModel: NSObject, ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var loginMessage: String? = nil
    @Published var loginLoading = false

    var loginResponse: LoginResponse?

    // MARK: 登录

    func login() async -> Bool {
        // 测试
        if EnvironmentUtil.isTestEnvironment() {
            updateUI { self.loginLoading = true }
            await Task.sleep(2)
            updateUI { self.loginLoading = false }
            return true
        }
        // 校验
        if let validMessage = isValid() {
            updateUI { self.loginMessage = validMessage }
            return false
        }
        updateUI { self.loginLoading = true }
        // 请求
        let api = LoginAPI()
        api.parameters = [
            "username": username,
            "password": password,
        ]

        do {
            let response: LoginResponse = try await NetworkManager.shared.request(api: api, responseType: LoginResponse.self)
            loginResponse = response
            if response.code == 200 {
                updateUI {
                    self.loginMessage = "登录成功！"
                    self.loginLoading = false
                }
                return true
            } else {
                updateUI {
                    self.loginMessage = response.msg
                    self.loginLoading = false
                }
                return false
            }
        } catch {
            updateUI {
                self.loginMessage = "登录失败：\(error.localizedDescription)"
                self.loginLoading = false
            }
            return false
        }
    }

    // MARK: Apple登录

    func appleLogin() async -> Bool {
        // 用户授权
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

        // 服务器校验
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
