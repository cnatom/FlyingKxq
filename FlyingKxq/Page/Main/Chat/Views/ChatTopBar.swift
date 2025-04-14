import SwiftUI

/// 聊天界面顶栏组件
struct ChatTopBar: View {
    let onMenuTap: () -> Void
    let onNewChat: () -> Void
    let title: String
    
    var body: some View {
        HStack(spacing: 16) {
            Button(action: onMenuTap) {
                Image(systemName: "line.3.horizontal")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            .padding(.leading)
            
            Text(title)
                .font(.headline)
            
            Spacer()
            
            Button(action: onNewChat) {
                Image(systemName: "square.and.pencil")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            .padding(.trailing)
        }
        .frame(height: 44)
        .background(Color(.systemBackground))
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color(.separator)),
            alignment: .bottom
        )
    }
}

#Preview {
    ChatTopBar(
        onMenuTap: {},
        onNewChat: {},
        title: "ChatGPT 4.0"
    )
} 