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
    @Published var avatarUrl: String
    @Published var name: String
    @Published var username: String
    @Published var bio: String
    @Published var level: Int
    @Published var fanNumber: Int
    @Published var followNumber: Int
    @Published var likeNumber: Int
    @Published var tags: [ProfileTag]
    init(imageUrl: String = "",
         name: String = "",
         username: String = "",
         bio: String = "",
         level: Int = 0,
         fanNumber: Int = 0,
         followNumber: Int = 0,
         likeNumber: Int = 0,
         tags: [ProfileTag] = []
    ) {
        avatarUrl = imageUrl
        self.name = name
        self.username = username
        self.bio = bio
        self.level = level
        self.fanNumber = fanNumber
        self.followNumber = followNumber
        self.likeNumber = likeNumber
        self.tags = tags
    }

    func getData() async -> Bool {
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
                        self.avatarUrl = data.avatar ?? ""
                        self.name = data.nickname ?? ""
                        self.username = data.username ?? ""
                        self.level = data.level ?? 0
                        self.fanNumber = data.followersCount ?? 0
                        self.followNumber = data.followingCount ?? 0
                        self.likeNumber = data.likeReceivedCount ?? 0
                        self.bio = data.bio ?? ""
                        if let status = data.status {
                            for s in status {
                                if let first = s.first, first.isEmoji {
                                    let content = String(s.dropFirst()) // 获取除第一个字符外的内容
                                    self.tags.append(ProfileTag(title: String(first), content: content))
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
