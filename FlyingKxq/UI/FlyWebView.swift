//
//  FlyWebView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/19.
//

import SwiftUI
import WebKit

typealias CookieHandler = (URL?, [HTTPCookie]) -> Void

struct FlyWebView: View {
    @State var progress: Double = 0.0
    @State var isLoading: Bool = false
    let handleCookies: CookieHandler?
    let url: URL

    init(
        url: URL,
        handleCookies: CookieHandler? = nil
    ) {
        self.url = url
        self.handleCookies = handleCookies
    }

    var body: some View {
        ZStack(alignment: .top) {
            FlyUIWebView(
                url: url,
                handleCookies: handleCookies,
                progress: $progress,
                isLoading: $isLoading)
            if isLoading {
                ProgressView(value: progress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle())
                    .transition(.opacity)
                    .animation(.easeInOut, value: isLoading)
            }
        }
    }
}

#Preview {
    FlyWebView(url: URL(string: "www.baidu.com")!)
}

struct FlyUIWebView: UIViewRepresentable {
    private let webView: WKWebView

    var url: URL

    let handleCookies: CookieHandler?

    @Binding var progress: Double

    @Binding var isLoading: Bool

    init(
        url: URL,
        handleCookies: CookieHandler? = nil,
        progress: Binding<Double> = .constant(0.0),
        isLoading: Binding<Bool> = .constant(false)
    ) {
        webView = WKWebView()
        self.handleCookies = handleCookies
        self.url = url
        _progress = progress
        _isLoading = isLoading
    }

    // MARK: UIViewRepresentable

    func makeUIView(context: Context) -> UIView {
        webView.navigationDelegate = context.coordinator
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: FlyUIWebView

        init(_ parent: FlyUIWebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // 拿到某个URL加载后的所有的Cookie

            Task {
                var url: URL?
                var retrievedCookies: [HTTPCookie] = []
                do {
                    if let urlString = try await webView.evaluateJavaScriptAsync("document.URL") as? String {
                        url = URL(string: urlString)
                    }
                } catch {
                    print("获取URL失败：\(error)")
                    url = nil
                }
                retrievedCookies = await WKWebsiteDataStore.default().httpCookieStore.getAllCookiesAsync()
                
                parent.handleCookies?(url, retrievedCookies)
            }
            

            parent.progress = 1.0
            parent.isLoading = false
        }

        public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            parent.progress = Double(webView.estimatedProgress)
        }
    }
}
