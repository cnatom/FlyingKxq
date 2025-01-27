//
//  ProfileHeaderModel.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/9.
//

import Foundation

struct ProfileHeaderModel {
    var avatarUrl: String = ""
    var name: String = ""
    var username: String = ""
    var bio: String = ""
    var hometown: String = ""
    var major: String = ""
    var grade: String = ""
    var gender: String = ""
    var level: Int = 0
    var fanNumber: Int = 0
    var followNumber: Int = 0
    var likeNumber: Int = 0
    var tags: [ProfileTag] = []
}

struct ProfileTag: Equatable, Identifiable {
    var id = UUID()
    var emoji: String
    var text: String
    var endTime: Date?
    var endTimeString: String {
        endTime == nil ? "" : endTime!.formatCountdownString()
    }
}
