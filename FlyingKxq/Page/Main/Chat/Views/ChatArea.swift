import SwiftUI

/// 聊天区域视图组件
struct ChatArea: View {
    let messages: [Message]
    let currentMessage: String
    let isLoading: Bool
    let onMessageChange: (String) -> Void
    let onSendMessage: () -> Void
    let onScrollToBottom: () -> Void
    
    var body: some View {
        VStack {
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
            
            // 输入区域
            HStack {
                TextField("输入消息...", text: Binding(
                    get: { currentMessage },
                    set: { onMessageChange($0) }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: onSendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                }
                .disabled(currentMessage.isEmpty || isLoading)
            }
            .padding()
        }
    }
} 