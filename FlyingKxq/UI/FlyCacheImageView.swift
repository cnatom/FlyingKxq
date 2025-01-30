//
//  FlyCacheImageView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/2.
//

import SwiftUI

struct FlyCachedImageView<ImageView: View, PlaceholderView: View>: View {
    @ViewBuilder var content: (Image) -> ImageView
    @ViewBuilder var placeholder: () -> PlaceholderView

    let url: URL?
    @State var image: UIImage? = nil
    let needToken: Bool

    init(
        url: URL?,
        needToken: Bool = false,
        @ViewBuilder content: @escaping (Image) -> ImageView,
        @ViewBuilder placeholder: @escaping () -> PlaceholderView
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
        self.needToken = needToken
    }

    var body: some View {
        VStack {
            if let uiImage = image {
                content(Image(uiImage: uiImage))
            } else {
                placeholder()
            }
        }
        .onAppear {
            Task {
                image = await downloadPhoto()
            }
        }
        .id(url)
        .animation(.easeInOut, value: image)
    }

    private func downloadPhoto() async -> UIImage? {
        do {
            guard let url = url else { return nil }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            if needToken {
                // 引入token
                guard let token = FlyKeyChain.shared.read(key: .token) else {
                    print("未找到Token")
                    return nil
                }
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            // 检查图片是否已缓存
            if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
                return UIImage(data: cachedResponse.data)
            } else {
                let (data, response) = try await URLSession.shared.data(for: request)

                // 缓存请求数据
                URLCache.shared.storeCachedResponse(CachedURLResponse(response: response, data: data), for: request)

                return UIImage(data: data)
            }
        } catch {
            print("下载图片失败: \(error)")
            return nil
        }
    }
}
