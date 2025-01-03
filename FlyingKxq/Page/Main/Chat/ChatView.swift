//
//  ChatView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        ScrollView{
            VStack {
                Text("ChatView")
                ForEach(0..<1000) { value in
                    Text("\(value)")
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ChatView()
}
