//
//  AppleLoginDelegate.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/19.
//

import AuthenticationServices
// MARK: - 处理 Apple 登录结果
class AppleSignInDelegate: NSObject, ASAuthorizationControllerDelegate {
    static let shared = AppleSignInDelegate()
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // 获取用户信息
            let userId = appleIDCredential.user
            let fullName = appleIDCredential.fullName?.formatted() ?? "未提供姓名"
            let email = appleIDCredential.email ?? "未提供邮箱"
            
            print("Apple 登录成功")
            print("User ID: \(userId)")
            print("姓名: \(fullName)")
            print("邮箱: \(email)")
            
            // 在这里保存或上传用户标识符和信息到您的服务器
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple 登录失败: \(error.localizedDescription)")
    }
}
