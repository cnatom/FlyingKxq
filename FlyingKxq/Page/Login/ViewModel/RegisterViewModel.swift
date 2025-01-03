//
//  RegisterViewModel.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/19.
//

import Alamofire
import Foundation
import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var schoolCertificationStatus = "点我认证"
    @Published var appleBindStatus = " 绑定"
    @Published var username = ""
    @Published var password = ""
    @Published var passwordConfirm = ""
    @Published var alertText: String?
    @Published var loading = false

    var unifiedAuthResponse: UnifiedAuthAPIResponse?
    var appleAuthorizationCodeString: String?
    var schoolCookie = HTTPCookie()

    // MARK: 统一认证绑定

    func cookieHandler(url: URL?, cookies: [HTTPCookie]) async -> Bool {
        guard let url = url, url.absoluteString.contains("portal.cumt.edu.cn"),
              let cookie = cookies.first(where: { $0.name.contains("SESS9595") }) else {
            return false
        }

        schoolCookie = cookie
        updateUI { self.schoolCertificationStatus = "正在进行认证……" }

        let api = UnifiedAuthAPI()
        api.headers["Cookie"] = "\(cookie.name)=\(cookie.value)"
        do {
            let res = try await NetworkManager.shared.request(api: api)
            unifiedAuthResponse = res
            updateUI { self.schoolCertificationStatus = res.code == 200 ? "认证成功 ✅" : (res.msg ?? "统一认证失败") }
            return res.code == 200
        } catch {
            updateUI { self.schoolCertificationStatus = "认证失败,请检查网络连接" }
            return false
        }
    }

    private func handleAuthResponse(_ result: Result<UnifiedAuthAPIResponse, AFError>) {
        switch result {
        case let .success(response):
            unifiedAuthResponse = response
            updateUI { self.schoolCertificationStatus = response.code == 200 ? "认证成功 ✅" : (response.msg ?? "统一认证失败") }
        case let .failure(error):
            let code = error.responseCode.map { "(\($0))" } ?? "(未知错误)"
            updateUI { self.schoolCertificationStatus = "认证失败,请检查网络连接\(code)" }
        }
    }

    // MARK: 苹果账号绑定

    func appleAccountBind() {
        Task {
            do {
                let appleSignInModel = try await AppleSignInUtil.shared.startAppleSignIn()
                appleAuthorizationCodeString = appleSignInModel.authorizationCodeString
                updateUI { self.appleBindStatus = "获取Apple ID成功 ✅" }
            } catch {
                updateUI { self.appleBindStatus = "绑定失败，请重试" }
            }
        }
    }

    // MARK: 注册请求

    func register() async -> Bool {
        // 测试
        if EnvironmentUtil.isTestEnvironment() {
            updateUI { self.loading = true }
            await Task.sleep(1.0)
            updateUI { self.loading = false }
            return false
        }
        // 校验
        updateUI { self.loading = true }
        if let validationErrorMessage = isValid() {
            updateUI {
                self.alertText = validationErrorMessage
                self.loading = false
            }
            return false
        }
        // 请求
        let api = RegisterAPI()
        api.parameters = [
            "username": username,
            "password": password,
            "unifiedAuthToken": unifiedAuthResponse?.data?.token,
            "appleAuthorizationCode": appleAuthorizationCodeString,
        ].compactMapValues { $0 }

        do {
            let response: RegisterAPIResponse = try await NetworkManager.shared.request(api: api)
            if response.code == 200 {
                if let token = response.data?.accessToken {
                    FlyKeyChain.shared.save(key: .token, value: token)
                }
                if let refreshToken = response.data?.refreshToken {
                    FlyKeyChain.shared.save(key: .refreshToken, value: refreshToken)
                }
                return true
            } else {
                updateUI {
                    self.alertText = response.msg ?? "注册失败，请检查网络连接"
                    self.loading = false
                }
                return false
            }
        } catch {
            updateUI { self.alertText = "网络请求失败,请检查网络连接" }
            updateUI { self.loading = false }
            return false
        }
    }

    // MARK: 输入校验

    private func isValid() -> String? {
        guard unifiedAuthResponse?.data?.token != nil else { return "请先认证矿大身份" }
        guard ValidationUtil.isValidUsername(username) else { return "用户名只能由英文字母、数字和下划线组成，且长度为6到16位" }
        guard ValidationUtil.isValidPassword(password) else { return "密码由8-20位组成，不能有空格" }
        guard password == passwordConfirm else { return "两次输入的密码不一致" }
        return nil
    }
}
