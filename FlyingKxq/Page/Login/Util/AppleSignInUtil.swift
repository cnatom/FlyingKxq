//
//  AppleSignInUtil.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/19.
//

import AuthenticationServices

class AppleSignInModel: NSObject {
    var userId: String
    var fullName: String
    var email: String
    var authorizationCodeString: String
    init(userId: String, fullName: String, email: String, authorizationCodeString: String) {
        self.userId = userId
        self.fullName = fullName
        self.email = email
        self.authorizationCodeString = authorizationCodeString
    }

    override var description: String {
        return """
        Apple 登录成功
        User ID: \(userId)
        姓名: \(fullName)
        邮箱: \(email)
        authorizationCode: \(authorizationCodeString)
        """
    }
}

class AppleSignInUtil: NSObject, ASAuthorizationControllerDelegate {
    static let shared = AppleSignInUtil()

    let requestedScopes: [ASAuthorization.Scope]? = [.fullName, .email]

    private var continuation: CheckedContinuation<AppleSignInModel, Error>?

    func startAppleSignIn() async throws -> AppleSignInModel {
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = requestedScopes
            let controller = ASAuthorizationController(authorizationRequests: [request])
            controller.delegate = self
            controller.performRequests()
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // 获取用户信息
            let userId = appleIDCredential.user
            let fullName = appleIDCredential.fullName?.formatted() ?? ""
            let email = appleIDCredential.email ?? ""
            let authorizationCodeString = appleIDCredential.authorizationCode.flatMap { String(data: $0, encoding: .utf8) } ?? ""
            continuation?.resume(returning: AppleSignInModel(userId: userId, fullName: fullName, email: email,authorizationCodeString: authorizationCodeString))
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple 登录失败: \(error.localizedDescription)")
        continuation?.resume(throwing: error)
    }
}
