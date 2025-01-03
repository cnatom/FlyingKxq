//
//  ProfileTabContent.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/3.
//

import SwiftUI

enum ProfileTabContent: View {
    case comment
    case text(_ text: String)
    case post(_ post: AnyView)
    var body: some View {
        switch self {
        case .comment:
            ProfileCommentView()
        case let .text(text):
            Text(text)
        case let .post(post):
            post
        }
    }
}

#Preview {
    ProfileTabContent.comment
}
