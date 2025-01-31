//
//  Untitled.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/31.
//
import SwiftUI

class NewsViewModel: ObservableObject {
    @Published var tab1List: [String] = ["关注","最新","热榜","校园","学院"]
    @Published var tab2List: [String] = ["最新","热门","关注","视频","图片"]
    func getNewsType(){
        Task {
            do {
                let api = NewsTypeAPI()
                let response = try await NetworkManager.shared.request(api: api)
                if response.code == 200 {
                    
                }
            } catch {
                
            }
        }
    }
}
