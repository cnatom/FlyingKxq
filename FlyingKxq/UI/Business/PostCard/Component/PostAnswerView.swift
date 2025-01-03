//
//  PostAnswerView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/2.
//

import SwiftUI

struct PostAnswerView: View {
    let leadingText: String
    let trailingText: String
    var body: some View {
        HStack(alignment:.top,spacing: 10){
            Text(leadingText)
                .font(.system(size: 12,weight: .regular))
                .foregroundStyle(Color.flyText)
            Spacer()
            Text(trailingText)
                .font(.system(size: 12,weight: .regular))
                .foregroundStyle(Color.flyTextGray)
        }
        .padding(.vertical,7)
        .padding(.horizontal,8)
        .background{
            RoundedRectangle(cornerRadius: 4)
                .foregroundStyle(Color.flySecondaryBackground)
        }
    }
}

#Preview {
    PostAnswerView(leadingText: "我是答案我是答案我是答案我是答案我是答案我是答案我是答案我是答案我是答案我是答案我是答案我是答案我是答案我是答案", trailingText: "赞 123")
}
