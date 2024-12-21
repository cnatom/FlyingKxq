//
//  WKWebView+async.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/19.
//

import WebKit

extension WKWebView {
    func evaluateJavaScriptAsync(_ script: String) async throws -> Any? {
        return try await withCheckedThrowingContinuation { continuation in
            self.evaluateJavaScript(script) { result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: result)
                }
            }
        }
    }
}

extension WKHTTPCookieStore {
    func getAllCookiesAsync() async -> [HTTPCookie] {
        await withCheckedContinuation { continuation in
            self.getAllCookies { cookies in
                continuation.resume(returning: cookies)
            }
        }
    }
}
