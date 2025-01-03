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

    // MARK: 登录

    func login() async -> Bool {
        // 测试
        if EnvironmentUtil.isTestEnvironment() {
            updateUI { self.loginLoading = true }
            await Task.sleep(1.0)
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
            let response: LoginAPIResponse = try await NetworkManager.shared.request(api: api)
            if response.code == 200 {
                // 存储token
                saveToken(accessToken: response.data?.accessToken, refreshToken: response.data?.refreshToken)
                // 登录成功
                updateUI {
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
            let response: AppleLoginAPIResponse = try await NetworkManager.shared.request(api: api)
            if response.code == 200 {
                // 登录成功
                saveToken(accessToken: response.data?.accessToken, refreshToken: response.data?.refreshToken)
                return true
            } else {
                updateUI { self.loginMessage = response.msg }
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
    // MARK: 存储Token
    
    private func saveToken(accessToken: String?,refreshToken: String?) {
        if let token = accessToken{
            FlyKeyChain.shared.save(key: .token, value: token)
        }
        if let refreshToken = refreshToken{
            FlyKeyChain.shared.save(key: .refreshToken, value: refreshToken)
        }
    }
}
