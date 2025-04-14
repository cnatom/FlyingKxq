import SwiftUI

/// 聊天区域视图组件
struct ChatArea: View {
    let messages: [Message]
    let isLoading: Bool
    let onScrollToBottom: () -> Void
    
    var body: some View {
        // 聊天消息列表
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(messages) { message in
                        MessageRow(message: message)
                    }
                    
                    if isLoading {
                        ProgressView()
                            .padding()
                    }
                }
                .padding()
                .onChange(of: messages.count) { _ in
                    onScrollToBottom()
                    withAnimation {
                        proxy.scrollTo(messages.last?.id, anchor: .bottom)
                    }
                }
            }
        }
    }
} 
