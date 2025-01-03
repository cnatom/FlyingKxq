//
//  Character+Emoji.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/7.
//

extension Character {
    var isEmoji: Bool {
        return unicodeScalars.first?.properties.isEmoji ?? false
    }
}
