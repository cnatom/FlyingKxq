//
//  LoginViewModel.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/17.
//

import AuthenticationServices
import Foundation

class LoginViewModel: ObservableObject {
    @Published var loginState: String = "未登录"
    @Published var username = ""
    @Published var password = ""

    // MARK: - Apple 登录功能

    func startAppleSignIn() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email] // 请求用户的姓名和邮箱

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = AppleSignInDelegate.shared
        controller.performRequests()
    }
}
