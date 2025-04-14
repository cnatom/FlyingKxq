import SwiftUI

struct MessageRow: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
            }
            
            VStack(alignment: message.isUser ? .trailing : .leading) {
                Text(message.content)
                    .padding()
                    .background(message.isUser ? Color.blue : Color(.systemGray6))
                    .foregroundColor(message.isUser ? .white : .primary)
                    .cornerRadius(16)
                
                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 4)
            }
            
            if !message.isUser {
                Spacer()
            }
        }
        .id(message.id)
    }
}

#Preview {
    VStack {
        MessageRow(
            message: Message(
                content: "你好，我是用户消息",
                isUser: true,
                timestamp: Date()
            )
        )
        
        MessageRow(
            message: Message(
                content: "你好，我是AI助手的回复消息",
                isUser: false,
                timestamp: Date()
            )
        )
    }
    .padding()
} 