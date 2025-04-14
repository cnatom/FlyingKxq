import SwiftUI

struct ChatSessionRow: View {
    let session: ChatSession
    let isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(session.title)
                .font(.headline)
                .foregroundColor(isSelected ? .blue : .primary)
            
            Text(session.lastUpdated, style: .date)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(isSelected ? Color.blue.opacity(0.1) : Color.clear)
        .cornerRadius(8)
    }
}

#Preview {
    ChatSessionRow(
        session: ChatSession(
            title: "测试会话",
            messages: [],
            lastUpdated: Date()
        ),
        isSelected: true
    )
} 