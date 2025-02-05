//
//  NewsListViewModel.swift
//  FlyingKxq
//
//  Created by atom on 2025/2/3.
//

import SwiftUI

class NewsListViewModel: ObservableObject {
    @Published var model = NewsListModel()
    var newsIDSet = Set<String>() // 防止重复请求
    var lastNewsID: String? // 用于记录最后一条数据的ID
    var lastCursor: String? // 用于记录最后一条数据的cursor
    init(model: NewsListModel = NewsListModel()) {
        self.model = model
    }

    func getData() async -> ToastLoadingModel? {
        // 请求过一次数据就不再请求
        if let lastNewsID = lastNewsID,
           newsIDSet.contains(lastNewsID) {
            return nil
        }
        var api = NewsListAPI()
        api.injectToken = true
        api.parameters = [
            "newsCategory": model.newsCategory,
            "newsType": model.newsType,
            "sourceName": model.sourceName,
            "size": 15,
            "sort": "time_desc",
        ]
        if let lastCursor = lastCursor,
           let lastNewsID = lastNewsID {
            api.parameters["cursor"] = lastCursor
            api.parameters["lastNewsId"] = lastNewsID
        }
        recordLastNewsID(lastNewsID)
        do {
            let response = try await NetworkManager.shared.request(api: api)
            if response.code == 200 {
                if let lastNewsID = response.data?.lastNewsID,
                   let cursor = response.data?.cursor {
                    self.lastNewsID = String(format: "%.0f", lastNewsID)
                    lastCursor = cursor
                }
                if let newsList = response.data?.newsList {
                    updateUI {
                        for item in newsList {
                            self.model.newsList.append(item)
                        }
                    }
                    return ToastLoadingModel(text: "加载成功", success: true)
                } else {
                    return ToastLoadingModel(text: "没有新闻啦～", success: true)
                }
            } else {
                removeLastNewsID(lastNewsID)
                return ToastLoadingModel(text: response.msg ?? "加载失败", success: false)
            }
        } catch {
            removeLastNewsID(lastNewsID)
            return ToastLoadingModel(text: "加载失败（\(error.localizedDescription)）", success: false)
        }
    }
}

extension NewsListViewModel {
    private func removeLastNewsID(_ value: String?) {
        if let lastNewsID = value {
            newsIDSet.remove(lastNewsID)
        }
    }

    private func recordLastNewsID(_ value: String?) {
        if let lastNewsID = value {
            newsIDSet.insert(lastNewsID)
        }
    }
}
