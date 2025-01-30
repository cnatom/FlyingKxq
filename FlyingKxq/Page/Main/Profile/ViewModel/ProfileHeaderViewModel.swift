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

    func editProfile(type: UserInfoEditType, value: String) async -> ToastLoadingModel {
        var valueTemp = value
        if type == .gender {
            switch value {
            case "男":
                valueTemp = "1"
            case "女":
                valueTemp = "0"
            default:
                valueTemp = "-1"
            }
        }
        var api = UserInfoEditAPI(type: type, value: valueTemp)
        api.injectToken = true
        do {
            let response: UserInfoEditAPIResponse = try await NetworkManager.shared.request(api: api)
            if response.code == 200 {
                updateUI {
                    switch type {
                    case .avatar:
                        self.model.avatarUrl = value
                    case .nickname:
                        self.model.name = value
                    case .bio:
                        self.model.bio = value
                    case .hometown:
                        self.model.hometown = value
                    case .major:
                        self.model.major = value
                    case .grade:
                        self.model.grade = value
                    case .gender:
                        self.model.gender = value
                    }
                }
                return ToastLoadingModel(text: "修改成功", success: true)
            } else {
                return ToastLoadingModel(text: "\(response.msg)", success: false)
            }
        } catch {
            return ToastLoadingModel(text: "修改失败,请检查网络连接", success: false)
        }
    }

    func uploadImage(uiImage: UIImage) async -> ToastLoadingModel {
        // 检查图片大小，如果超过 5M 则提示
        guard let imageSize = uiImage.sizeKB, imageSize < 1024 * 10 else {
            return ToastLoadingModel(text: "请选择10M以内的图片", success: false)
        }
        // 压缩图片
        guard let compressedData = await uiImage.compress(to: 200) else {
            return ToastLoadingModel(text: "", success: false)
        }
        // 上传
        var api = UserInfoEditAPI(type: .avatar)
        api.injectToken = true
        api.parameters["file"] = compressedData
        do {
            let response: UserInfoEditAPIResponse = try await NetworkManager.shared.request(api: api)
            if response.code == 200 {
                updateUI {
                    self.model.avatarUrl = response.data ?? ""
                }
                return ToastLoadingModel(text: "上传成功", success: true)
            } else {
                return ToastLoadingModel(text: "\(response.msg)", success: false)
            }
        } catch {
            return ToastLoadingModel(text: "上传失败,请检查网络连接", success: false)
        }
    }

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
                            self.model.gender = "保密"
                        }
                        self.model.bio = data.bio ?? ""
                        self.model.hometown = data.hometown ?? ""
                        self.model.major = data.major ?? ""
                        self.model.grade = data.grade ?? ""
                        if let status = data.status {
                            for s in status {
                                guard let emoji = s.emoji,
                                      let text = s.text,
                                      let endTime = s.endTime
                                else { continue }
                                self.model.tags.append(
                                    ProfileTag(
                                        emoji: emoji,
                                        text: text,
                                        endTime: Date.fromISOString(endTime)
                                    )
                                )
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
