import SwiftUI

/// 聊天侧边栏视图组件
struct ChatSidebar: View {
    let sessions: [ChatSession]
    let currentSessionId: UUID?
    let offset: CGFloat
    let onSessionSelect: (ChatSession) -> Void
    let onCreateNewChat: () -> Void
    
    var body: some View {
        VStack {
            // 聊天会话列表
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    ForEach(sessions.sorted(by: { $0.lastUpdated > $1.lastUpdated })) { session in
                        Button(action: { onSessionSelect(session) }) {
                            ChatSessionRow(
                                session: session,
                                isSelected: session.id == currentSessionId
                            )
                        }
                    }
                }
                .padding()
            }
            
            // 新建聊天按钮
            Button(action: onCreateNewChat) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("新建聊天")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .frame(width: UIScreen.main.bounds.width * 0.6)
        .background(Color(.systemBackground))
        .offset(x: offset)
    }
} 