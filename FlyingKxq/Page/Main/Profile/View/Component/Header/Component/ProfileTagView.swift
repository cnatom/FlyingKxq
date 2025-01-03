//
//  ProfileTagView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/25.
//

import SwiftUI

struct ProfileTagView: View {
    let title: String
    let content: String?
    init(title: String, content: String? = nil) {
        self.title = title
        self.content = content
    }
    var body: some View {
        HStack(spacing: 12) {
            Text(title)
                .font(.system(size: 12,weight: .regular))
                .foregroundStyle(Color.flyTextGray)
            Text(content ?? "")
                .font(.system(size: 12,weight: .regular))
                .foregroundStyle(Color.flyText)
        }
        .padding(.horizontal,16)
        .frame(height: 26)
        .background {
            RoundedRectangle(cornerRadius: 4)
                .foregroundStyle(Color.flySecondaryBackground)
        }
    }
}

#Preview {
    ProfileTagView(
        title: "标题"
    )
}
