//
//  Untitled.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/31.
//
import SwiftUI

class NewsViewModel: ObservableObject {
    @Published var model = NewsModel()
    @Published var index1: Int = 0 // 学院、学校
    @Published var index2: Int = 0 // 各个学院
    @Published var index3: Int = 0 // 各类新闻
    var loaded: Bool = false
    func getNewsType() {
        Task {
            if loaded {
                return
            }
            if model.typeList.isEmpty {
                updateUI {
                    self.getLocalData()
                }
            }
            do {
                var api = NewsTypeAPI()
                api.injectToken = true
                let response = try await NetworkManager.shared.request(api: api)
                if response.code == 200 {
                    loaded = true
                    updateUI {
                        var typeList = [NewsSource]()
                        for category in response.data?.newsCategory ?? [] {
                            typeList.append(category)
                        }
                        self.model.typeList = typeList
                    }
                    self.saveLocalData()
                } else {
                    print("错误")
                    print(response.msg ?? "")
                }
            } catch {
                print("错误")
            }
        }
    }
}

extension NewsViewModel {
    private func getLocalData() {
        let store = FlyUserDefaults.shared
        if let data: Data = store.get(.newsType),
           let typeList = try? JSONDecoder().decode([NewsSource].self, from: data) {
            model.typeList = typeList
        }
    }

    private func saveLocalData() {
        let store = FlyUserDefaults.shared
        if let encodingData = try? JSONEncoder().encode(model.typeList) {
            store.set(encodingData, for: .newsType)
        }
    }
}
