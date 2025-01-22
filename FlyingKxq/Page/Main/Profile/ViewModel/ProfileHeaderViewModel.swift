//
//  ProfileHeaderViewModel.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/7.
//

import Alamofire
import SwiftUI

class ProfileHeaderViewModel: ObservableObject {
    var loading = false
    @Published var model = ProfileHeaderModel()

    func getData() async -> Bool {
        if model.username != "" { return false }
        if loading { return false }
        loading = true
        var api = UserInfoAPI()
        api.injectToken = true
        do {
            let response = try await NetworkManager.shared.request(api: api)
            if response.code == 200,
               let data = response.data {
                updateUI {
                    withAnimation {
                        self.model.avatarUrl = data.avatar ?? ""
                        self.model.name = data.nickname ?? ""
                        self.model.username = data.username ?? ""
                        self.model.level = data.level ?? 0
                        self.model.fanNumber = data.followersCount ?? 0
                        self.model.followNumber = data.followingCount ?? 0
                        self.model.likeNumber = data.likeReceivedCount ?? 0
                        switch data.gender {
                        case 1:
                            self.model.gender = "男"
                        case 0:
                            self.model.gender = "女"
                        default:
                            self.model.gender = ""
                        }
                        self.model.bio = data.bio ?? ""
                        if let status = data.status {
                            for s in status {
                                if let first = s.first, first.isEmoji {
                                    let content = String(s.dropFirst()) // 获取除第一个字符外的内容
                                    self.model.tags.append(ProfileTag(emoji: String(first), name: content))
                                }
                            }
                        }
                    }
                }
                loading = false
                return true
            } else {
                loading = false
                return false
            }
        } catch {
            loading = false
            return false
        }
    }
}
